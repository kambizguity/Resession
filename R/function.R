CheckNumber <- function (param, bHour) {
  if (is.na(as.numeric(param))) {
    print("Non Numeric")
    return ("00")
  } else {
    print("Numeric")
    param <- as.numeric(param)
    if (param < 0) {
      param <- "00"
    } else if (param >= 0 && param < 10) {
      param <- paste ("0", param, sep = "")
      return (param)
    } else {
      if (bHour && param > 23) {
        return ("00")
      }  else if (!bHour && param > 59) {
        return ("00")
      }
    }
    return (toString(param))
  }
}
