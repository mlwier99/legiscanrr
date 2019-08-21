#' Wrapper for getDatasetList operation
#'
#' Returns a list of available datasets, with optional state and year filtering
#'
#' @param api_key LegiScan API key (required)
#' @param state State filter (optional)
#' @param year Year filter (optional)
#'
#' @import attempt
#' @import httr
#' @importFrom data.table rbindlist
#'
#' @return data.frame
#'
#' @export
get_dataset_list <- function(api_key, state = NULL, year = NULL){

  # Stop if no api_key is given
  if (missing(api_key)) {
    stop("Must specify API key. Register for one at https://legiscan.com/legiscan")
  }

  # Chek for internet
  check_internet()

  # Get the API response
  resp <- httr::GET(
    url = base_url,
    query = list(key = api_key, op = "getDatasetList", state = state, year = year))

  # Get the content
  content <- httr::content(resp)

  # Check for errors in http status, http type, and API errors
  check_http_status(resp)
  check_API_response(content)

  # Keep the inner element content
  content <- content[["datasetlist"]]

  content
}
