wrk.method = "POST"
wrk.headers["Content-Type"] = "application/json"
wrk.body = [[{
    "title": "Title",
    "summary": "Summary",
    "publication_date": "2021-01-01"
}]]

-- vim: sw=4:et:ai
