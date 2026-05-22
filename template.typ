// 使用伪粗体修复中文粗体不能正确显示的问题
#import "@preview/cuti:0.4.0": show-cn-fakebold
#import "@preview/gb7714-bilingual:0.2.3": init-gb7714
#import "@preview/subpar:0.2.2"

#import "fonts/font.typ": *
#import "pages/chinese-outline.typ": chinese_outline
#import "pages/declaration.typ": declaration
#import "pages/zh-abstract-page.typ": zh_abstract_page
#import "pages/en-abstract-page.typ": en_abstract_page
#import "pages/cover.typ": paper_cover
#import "pages/paper-pages.typ": *

#import "utilities/indent-funs.typ": *
#import "utilities/set-heading.typ": _set_heading
#import "utilities/set-figure.typ": _set_figure
#import "utilities/set-numbering.typ": _set_numbering

#let sub-figure-numbering = (super, sub) => numbering("1.1a", counter(heading).get().first(), super, sub)
#let figure-numbering = super => numbering("1.1", counter(heading).get().first(), super)
#let subpar-grid = subpar.grid.with(
  numbering: figure-numbering,
  numbering-sub-ref: sub-figure-numbering,
)

#let project(
  anonymous: false, // 是否匿名化处理
  title: "",
  title2: 0, // 标题要被切成两行，这是第一行的字数
  abstract_zh: [],
  abstract_en: [],
  keywords_zh: (),
  keywords_en: (),
  school: "",
  department: "",
  major: "",
  author: "",
  id: "",
  grade: "",
  mentor: "",
  class: "",
  date: (1926, 8, 17),
  作者声明日期: (2025, 5, 16),
  作者签名图片: "signature.png",
  bib-content: read("ref.bib"),
  body,
) = {
  let full_title = title + title2
  /* 全局整体设置 */
  set text(lang: "zh", region: "cn")


  // 设置标题, 需要在图表前设置
  show: _set_heading
  // 图表公式的排版
  show: _set_figure
  // 图表公式的序号
  show: _set_numbering
  // 修复缩进
  show: _fix_indent
  // 整体页面设置
  show: _set_paper_page_size
  // 修复中文粗体不能正确显示的问题
  show: show-cn-fakebold

  /* 封面与原创性声明 */

  // 封面
  paper_cover(
    cover_logo_path: "../assets/ecust.jpg",
    anonymous,
    title,
    title2,
    school,
    department,
    major,
    grade,
    id,
    author,
    mentor,
    date,
  )

  // 需要插入任务书则取消下面的注释
  /*
  for i in range(1, 3) {
    set page(margin: 0pt)
    image("任务书.pdf", page: i)
  }
  */

  // 原创性声明
  declaration(anonymous: anonymous, signature: 作者签名图片, date: 作者声明日期)

  // 原创性声明与摘要间的空页
  // pagebreak()
  counter(page).update(0)

  // 进入下一部分
  pagebreak()
  counter(page).update(1)

  /* 目录与摘要 */

  // 整体页眉
  show: _set_paper_page_header.with(anonymous: anonymous, title: full_title, show_page: false)
  // 目录与摘要的页脚
  show: _set_paper_page_footer_pre
  // 整体段落与页面设置
  show: _set_paper_page_par

  // 摘要
  zh_abstract_page(abstract_zh, keywords: keywords_zh)

  pagebreak()

  // abstract
  en_abstract_page(abstract_en, keywords: keywords_en)

  pagebreak()

  // 目录
  chinese_outline()

  show: init-gb7714.with(bib-content, style: "numeric", version: "2015", show-url: false, show-doi: false)

  /* 正文 */

  // 正文的页脚
  show: _set_paper_page_header.with(anonymous: anonymous, title: full_title, show_page: true)
  show: _set_paper_page_footer_main

  // https://forum.typst.app/t/how-to-have-headings-without-numbers-in-a-fluent-way/3457
  show selector(<nonumber>): set heading(numbering: none)

  set enum(indent: 2em)

  set list(indent: 2em)

  counter(page).update(1)

  body
}
