% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_bill_masterlist.R
\name{get_bill_masterlist}
\alias{get_bill_masterlist}
\title{Get master list of bills in a session}
\usage{
get_bill_masterlist(state = NULL, session_id = NULL,
  api_key = legiscan_api_key())
}
\arguments{
\item{state}{Two letter abbreviation of the state}

\item{session_id}{Session identifier}

\item{api_key}{Your LegiScan API key (see \code{\link{legiscan_api_key}})}
}
\value{
Data frame of bill information in the session requested,
including `bill_id` and other information.
}
\description{
This is the API wrapper function for the getMasterList operation.
It returns a master list of bills in a given session,
or in the current session of a given state.
}
\details{
Only one of the two parameters are accepted: specifying \code{state} paramter
returns the bill master list of the current session from that state; specifying
the \code{session_id} parameter returns the bill master list of that specific session.
}
\examples{
\dontrun{
# One state
get_bill_masterlist(state = "PA")

# Multiple states, use iterators, e.g. lapply() or map()
state_list <- c("AR", "AZ")
bills_current <- lapply(state_list, get_bill_masterlist)
}

}
\seealso{
\code{\link{legiscan_api_key}},
\href{https://legiscan.com/gaits/documentation/legiscan}{LegiScan API manual}.
}
