#' Parse individual legislator voting record
#'
#' Parse individual legislator's vote in each roll call from local json.
#' (support for parsing from API response not yet available.)
#'
#' @param vote_json Path to vote json file
#'
#' @import jsonlite
#' @import progress
#' @importFrom data.table rbindlist setDF
#' @importFrom  tibble as_tibble
#'
#' @examples
#' vote <- system.file("extdata", "vote/154366.json", package = "legiscanrr")
#' vote <- parse_person_vote(vote)
#' str(vote)
#'
#' @return A data frame of 4 columns.
#' For more details, see \href{../articles/parse-json.html#legislator-vote-records}{documentation}.
#'
#' @export
parse_person_vote <- function(vote_json){

  # Initialize progress bar
  pb <- progress::progress_bar$new(
    format = "  parsing person-vote [:bar] :percent in :elapsed.",
    total = length(vote_json), clear = FALSE, width= 60)
  pb$tick(0)

  extract_vote <- function(input_vote_json){

    pb$tick()

    # Import json
    input_vote <- jsonlite::fromJSON(input_vote_json)

    # Keep inner element
    input_vote <- input_vote[["roll_call"]]

    person_vote <- input_vote[["votes"]]
    #person_vote$bill_id <- input_vote[["bill_id"]]
    person_vote$roll_call_id <- input_vote[["roll_call_id"]]

    person_vote
    # End of inner function call
  }

  # Iterate over input json to decode text one by one
  output_list <- lapply(vote_json, extract_vote)

  # Bind list into flat data frame
  output_df <- data.table::rbindlist(output_list, fill = TRUE)
  output_df  <- tibble::as_tibble(data.table::setDF(output_df))
  output_df
  # End of function call
}

