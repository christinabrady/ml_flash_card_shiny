### helper functions and global variables for this shiny app

dbconnect <- readLines("include/dbconnect.txt")

updateTable <- function(con, var1, cardname){
  card_dat <- sqlQuery(con,
    sprintf("SELECT * FROM ml_flash_cards WHERE card = '%s'", cardname)
  )
  previous_correct <- card_dat[, var1]
  total <- card_dat$times_seen
  qry <- sprintf("UPDATE ml_flash_cards
    SET %s = '%s', times_seen = '%s'
    WHERE card = '%s'",
    var1,
    previous_correct + 1,
    total + 1,
    cardname)
  sqlQuery(con, qry)
  # print(qry)
}
