FROM trestletech/plumber
LABEL maintainer="serhatcevikel@yahoo.com"

RUN R -e "install.packages(c('httr', 'jsonlite', 'e1071', 'rpart'), \
repos = 'http://cran.us.r-project.org')"

COPY ./plumber4.R /plumber4.R

EXPOSE 8000

ENTRYPOINT ["R", "-e", \
"predict <- plumber::plumb('plumber4.R'); \
predict$run(host = '0.0.0.0', port= 8000)"]

CMD ["/plumber4.R"]
