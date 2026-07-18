#!/usr/bin/env python3
"""Convert Arabic lecture markdown files to PDF using fpdf2."""

import os
import re

from fpdf import FPDF

BASE = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
FONT_DIR = "/usr/share/fonts/truetype"
OUT_DIR = os.path.join(BASE, "PDF")
os.makedirs(OUT_DIR, exist_ok=True)

MAIN       = os.path.join(FONT_DIR, "dejavu/DejaVuSans.ttf")
MAIN_BOLD  = os.path.join(FONT_DIR, "dejavu/DejaVuSans-Bold.ttf")
MONO       = os.path.join(FONT_DIR, "dejavu/DejaVuSansMono.ttf")
MONO_BOLD  = os.path.join(FONT_DIR, "dejavu/DejaVuSansMono-Bold.ttf")

GREEN = (21, 128, 61)
GOLD  = (234, 179, 8)
DARK  = (15, 23, 42)
WHITE = (255, 255, 255)
GRAY  = (100, 116, 139)
LIGHT = (248, 250, 252)
BLUE  = (10, 165, 233)

class LecturePDF(FPDF):
    def __init__(self, title):
        super().__init__(orientation='P', unit='mm', format='A4')
        self.add_font("Ar", "", MAIN)
        self.add_font("Ar", "B", MAIN_BOLD)
        self.add_font("Code", "", MONO)
        self.add_font("Code", "B", MONO_BOLD)
        self.set_auto_page_break(auto=True, margin=20)
        self.title_text = title
        self._in_code_block = False

    def header(self):
        if self.page_no() > 1:
            self.set_font("Ar", "B", 8)
            self.set_text_color(*GRAY)
            self.cell(0, 6, self.title_text, new_x="LMARGIN", new_y="NEXT", align="R")
            self.set_draw_color(*GOLD)
            self.line(10, 12, 200, 12)
            self.ln(4)

    def footer(self):
        self.set_y(-15)
        self.set_font("Ar", "", 8)
        self.set_text_color(*GRAY)
        self.cell(0, 10, f"- {self.page_no()} -", align="C")


def parse_table_row(line):
    cells = [c.strip() for c in line.split("|")]
    return [c for c in cells if c != ""]


def is_table_row(line):
    return line.startswith("|") and line.endswith("|")


def is_table_sep(line):
    return bool(re.match(r"^[\s\|:\-]+$", line)) and "---" in line


def mc(pdf, w, h, text, align="R", fill=False, font_family="Ar", font_style="", font_size=10, text_color=None, fill_color=None):
    if font_color := text_color:
        pdf.set_text_color(*font_color)
    else:
        pdf.set_text_color(*DARK)
    pdf.set_font(font_family, font_style, font_size)
    if fill:
        if fill_color:
            pdf.set_fill_color(*fill_color)
        else:
            pdf.set_fill_color(*LIGHT)
        pdf.multi_cell(w, h, text, align=align, fill=True)
    else:
        pdf.multi_cell(w, h, text, align=align)


def write_pdf(md_path, pdf_path):
    with open(md_path, "r", encoding="utf-8") as f:
        lines = f.read().split("\n")

    pdf = LecturePDF(os.path.basename(pdf_path))
    pdf.add_page()
    pw = 190

    in_table = False
    table_headers = []
    table_rows = []
    sep_found = False
    i = 0
    n = len(lines)

    def flush_table():
        nonlocal in_table, table_headers, table_rows, sep_found
        if not table_headers and not table_rows:
            return

        if not table_headers:
            table_headers = table_rows[0] if table_rows else []
            table_rows = table_rows[1:] if len(table_rows) > 1 else []

        if not table_headers and not table_rows:
            in_table = False
            sep_found = False
            return

        col_count = max(len(table_headers), max((len(r) for r in table_rows), default=0))
        while len(table_headers) < col_count:
            table_headers.append("")
        for r in table_rows:
            while len(r) < col_count:
                r.append("")

        col_w = pw / col_count

        # Estimate header height
        pdf.set_font("Ar", "B", 9)
        h_lines = []
        for ch in table_headers:
            ls = pdf.multi_cell(col_w - 1, 6, ch, dry_run=True, output="LINES")
            h_lines.append(len(ls))
        h_row_h = max(h_lines) * 6
        if pdf.get_y() + h_row_h > 270:
            pdf.add_page()

        # Draw header
        y0 = pdf.get_y()
        for ci, ch in enumerate(table_headers):
            x0 = 10 + ci * col_w
            pdf.set_fill_color(*GREEN)
            pdf.set_draw_color(*GREEN)
            pdf.rect(x0, y0, col_w, h_row_h, style="DF")
            pdf.set_text_color(*WHITE)
            pdf.set_font("Ar", "B", 9)
            pdf.set_xy(x0 + 0.5, y0 + 1)
            pdf.multi_cell(col_w - 1, 6, ch, align="C")

        pdf.set_xy(10, y0 + h_row_h)

        # Data rows
        for ri, row in enumerate(table_rows):
            pdf.set_font("Ar", "", 9)
            d_lines = []
            for ch in row:
                ls = pdf.multi_cell(col_w - 1, 6, ch, dry_run=True, output="LINES")
                d_lines.append(len(ls))
            d_row_h = max(d_lines) * 6

            if pdf.get_y() + d_row_h > 270:
                pdf.add_page()

            yd = pdf.get_y()
            pdf.set_draw_color(*GREEN)
            for ci, ch in enumerate(row):
                xd = 10 + ci * col_w
                if ri % 2 == 0:
                    pdf.set_fill_color(*LIGHT)
                else:
                    pdf.set_fill_color(*WHITE)
                pdf.rect(xd, yd, col_w, d_row_h, style="DF")
                pdf.set_text_color(*DARK)
                pdf.set_font("Ar", "", 9)
                pdf.set_xy(xd + 0.5, yd + 1)
                pdf.multi_cell(col_w - 1, 6, ch, align="C")
            pdf.set_xy(10, yd + d_row_h)

        pdf.ln(4)
        table_headers = []
        table_rows = []
        in_table = False
        sep_found = False

    while i < n:
        line = lines[i]

        # Code blocks
        if line.strip().startswith("```"):
            pdf._in_code_block = not pdf._in_code_block
            i += 1
            continue

        if pdf._in_code_block:
            if pdf.get_y() + 7 > 270:
                pdf.add_page()
            pdf.set_font("Code", "", 8)
            pdf.set_fill_color(15, 23, 42)
            pdf.set_text_color(226, 232, 240)
            pdf.set_x(10)
            pdf.multi_cell(pw, 6, line.rstrip(), align="L", fill=True)
            i += 1
            continue

        # Table rows
        if is_table_row(line) and not is_table_sep(line):
            cells = parse_table_row(line)
            if not in_table:
                in_table = True
                table_headers = []
                table_rows = []
                sep_found = False
            if not sep_found and not table_rows:
                table_rows.append(cells)
            else:
                table_rows.append(cells)
            i += 1
            continue

        if is_table_sep(line) and in_table:
            sep_found = True
            if table_rows:
                table_headers = table_rows[0]
                table_rows = table_rows[1:]
            i += 1
            continue

        if in_table:
            flush_table()

        s = line.strip()

        if s == "---":
            pdf.set_draw_color(*GOLD)
            pdf.line(10, pdf.get_y() + 2, 200, pdf.get_y() + 2)
            pdf.ln(6)
            i += 1
            continue

        if not s:
            pdf.ln(3)
            i += 1
            continue

        if s.startswith("# "):
            mc(pdf, pw, 9, s[2:].strip(), font_style="B", font_size=16, text_color=GREEN)
            pdf.set_draw_color(*GOLD)
            pdf.line(10, pdf.get_y() + 1, 200, pdf.get_y() + 1)
            pdf.ln(4)
            i += 1
            continue

        if s.startswith("## "):
            mc(pdf, pw, 8, s[3:].strip(), font_style="B", font_size=13, text_color=GREEN)
            pdf.set_draw_color(*GOLD)
            pdf.line(10, pdf.get_y(), 60, pdf.get_y())
            pdf.ln(3)
            i += 1
            continue

        if s.startswith("### "):
            mc(pdf, pw, 7, s[4:].strip(), font_style="B", font_size=11, text_color=BLUE)
            pdf.ln(2)
            i += 1
            continue

        # List items
        lm = re.match(r"^(\s*)([\-\*]|\d+\.)\s+(.*)", s)
        if lm:
            prefix = lm.group(1)
            bullet = lm.group(2)
            text = lm.group(3)
            is_check = text.startswith("\u2705")
            display = text[1:].strip() if is_check else text
            indent_val = len(prefix) * 2 + 5
            bchar = "\u2022" if bullet in ("-", "*") else bullet.rstrip(".")
            txt = f"{bchar}  {display}"
            mc(pdf, pw - indent_val, 6.5, txt, font_style="B" if is_check else "", font_size=10,
               text_color=GREEN if is_check else DARK)
            pdf.ln(1)
            i += 1
            continue

        # Bold-only line
        if re.match(r"^\*\*.*\*\*$", s):
            mc(pdf, pw, 7, s.replace("**", ""), font_style="B", font_size=10, text_color=GRAY)
            pdf.ln(1)
            i += 1
            continue

        # Paragraph with possible inline bold
        parts = re.split(r"(\*\*.*?\*\*)", s)
        if len(parts) > 1:
            for part in parts:
                if not part:
                    continue
                if part.startswith("**") and part.endswith("**"):
                    mc(pdf, pw, 6.5, part[2:-2], font_style="B", font_size=10, text_color=DARK)
                else:
                    mc(pdf, pw, 6.5, part, font_size=10, text_color=DARK)
        else:
            mc(pdf, pw, 6.5, s, font_size=10, text_color=DARK)
        pdf.ln(1)
        i += 1

    if in_table:
        flush_table()

    pdf.output(pdf_path)
    return pdf.pages_count


def main():
    files = []
    lectures_dir = os.path.join(BASE, "\u0627\u0644\u0645\u062D\u0627\u0636\u0631\u0627\u062A")
    if not os.path.isdir(lectures_dir):
        print(f"Error: Lectures directory not found: {lectures_dir}")
        return
    for entry in sorted(os.listdir(lectures_dir)):
        sub = os.path.join(lectures_dir, entry)
        if not os.path.isdir(sub):
            continue
        for n in range(1, 11):
            for name in (f"\u062E\u0637\u0629 \u0627\u0644\u0645\u062D\u0627\u0636\u0631\u0629 {n}.md",
                         f"\u062A\u062D\u0644\u064A\u0644 \u0627\u0644\u0645\u062D\u0627\u0636\u0631\u0629 {n}.md"):
                p = os.path.join(sub, name)
                if os.path.exists(p):
                    files.append(p)

    created = []
    for md in sorted(files):
        base = os.path.splitext(os.path.basename(md))[0]
        pdf_name = base + ".pdf"
        pdf_path = os.path.join(OUT_DIR, pdf_name)
        print(f"Converting: {os.path.basename(md)} -> {pdf_name}")
        pages = write_pdf(md, pdf_path)
        created.append(pdf_name)
        print(f"  -> {pages} page(s)")

    print(f"\nDone. {len(created)} PDFs in: {OUT_DIR}")
    for f in created:
        print(f"  * {f}")


if __name__ == "__main__":
    main()
