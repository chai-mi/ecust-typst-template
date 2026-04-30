#import "@preview/pointless-size:0.1.2": zh

#import "../fonts/font.typ": *

// 中文摘要
#let zh_abstract_page(abstract, keywords: ()) = {
  set heading(level: 1, numbering: none)
  show <_zh_abstract_>: {
    align(center)[
      #text(font: heiti, size: zh(2.5), "摘要")
    ]
  }
  [= 摘要 <_zh_abstract_>]

  set text(font: songti, size: zh(4.5))

  abstract
  par(first-line-indent: 0em)[
    #text(weight: "bold", font: heiti, size: zh(4.5))[
      关键词：
    ]
    #text(weight: "regular", font: songti, size: zh(4.5))[
      #keywords.join("，")
    ]
  ]
}
