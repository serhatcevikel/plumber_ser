# By Serhat Çevikel
# serhatcevikel@yahoo.com
# serhat.cevikel@boun.edu.tr

#* @get /func5
#* @post /func5

function(req)
{
    require(jsonlite)
    require(httr)
    require(e1071)
    require(rpart)
    
    body <- req$body
    
    csv_df <- read.csv(text = rawToChar(body$csv$value))
    model <- rawToChar(body$model$value)
    schema <- rawToChar(body$schema$value)
    id <- rawToChar(body$id$value)
   
    class(model) <- "json"
    class(schema) <- "json"
    csv_df2 <- unserializeJSON(schema)
    modelx <- unserializeJSON(model)
    csv_df2[1:nrow(csv_df),] <- csv_df
    predictions <- predict(modelx, csv_df2)

    ids <- if (! id %in% names(csv_df2)) seq_along(predictions) else csv_df2[[id]]

    return(list(results = data.frame(id = ids, predictions = predictions)))
}