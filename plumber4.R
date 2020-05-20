# By Serhat Çevikel
# serhatcevikel@yahoo.com
# serhat.cevikel@boun.edu.tr
# run the generic predict function for a serialized model object and csv data
# a serialized schema object defines the class and attributes of data columns (for factors, etc)

#* @get /func4
#* @post /func4

function(req, model, csv, schema, id = "id")
{
    require(jsonlite)
    require(httr)
    require(e1071)
    require(rpart)

    csv_df <- read.csv(text = csv)
    class(model) <- "json" 
    class(schema) <- "json"
    csv_df2 <- unserializeJSON(schema)
    modelx <- unserializeJSON(model)
    csv_df2[1:nrow(csv_df),] <- csv_df # the schema is applied to imported data
    predictions <- predict(modelx, csv_df2)

    # define ids for results
    ids <- if (! id %in% names(csv_df2)) seq_along(predictions) else csv_df2[[id]]

    return(list(results = data.frame(id = ids, predictions = predictions)))
}

