add_input_ext('latex', 'md');
add_cus_dep('md', 'tex', 0, 'md2tex');
sub md2tex {
    system("pandoc -R $_[0].md --slide-level 3 -t beamer -o $_[0].tex");
}
$pdflatex = 'pdflatex -shell-esc -interaction=nonstopmode -synctex=1';
$pdf_mode = 1;
$view = 'pdf';
$pdf_previewer = 'open -a /Applications/TeX/TeXShop.app';
$cleanup_includes_cusdep_generated = 1;
$cleanup_includes_generated = 1;
$clean_ext = 'fls vrb m9 nav run.xml snm bbl synctex.gz';
