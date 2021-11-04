open date
type date = {day: int; month: int; year: int}

let create d m y =
  let newDate = {day: d; month: m; year: y}
  newDate
