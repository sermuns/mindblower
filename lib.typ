#import "@preview/fletcher:0.5.8"
#set page(width: auto, height: auto, margin: .5cm)
#set text(font: "Libertinus Sans")

#let list-to-array(it) = {
  if it.has("children") {
    for child in it.children {
      if child == [ ] { continue }
      (list-to-array(child),)
    }
  } else if it.has("body") {
    list-to-array(it.body)
  } else if type(it) == content {
    it
  }
}

#let arr = list-to-array[
  - Sports #sym.emptyset ok this is weird #sym.angle #sym.BB HOLY SHIT
  // - Individual sports
  //   - Track
  //   - Cycling
  // - Contact sports
  //   - Football
  //     - American football
  //   - Basketball
  // - Water Sports
  //   - Diving
  //   - Swimming
  //     - Figure swimming
]

#let spread = 5
#let array-to-nodes(arr) = {
  import fletcher: edge, node
  import calc: cos, sin

  let len = arr.len()
  let angles = range(len).map(i => i / len * 360deg)
  for (angle, item) in angles.zip(arr) {
    if type(item) == array {
      node((rel: (angle, spread)), none)
      array-to-nodes(item)
    } else {
      node((rel: (angle, spread)), item + [ #angle])
    }
  }
}


#let mindmap(array) = fletcher.diagram(debug: 1, spacing: .5em, {
  import fletcher: edge, node
  let edge = edge.with(marks: "-}>")
  array-to-nodes(array)
})

#mindmap(arr)
