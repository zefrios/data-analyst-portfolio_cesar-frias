library(tidyverse)
library(shiny)
library(DT)
library(dplyr)
library(shinydashboard)
library(networkD3)
library(shinythemes)
library(dashboardthemes)
library(shinyBS)
library(ggpubr)
library(corrplot)
library(RColorBrewer)
library(shinyWidgets)


load("df_Final.RData")

#####################  HTML Codes  #######################################

mycss <- "
#box1:active, #box2:active {
  background-color: #191414 !important;
}
"


box_background_gray <-   "#box3 {
                                  text-align: center;
                                }

                          .box.box-solid.box-primary>.box-header {
                          color:#fff;
                          background:#2c3444 }

                          .box.box-solid.box-primary{
                          border-bottom-color:#2c3444;
                          border-left-color:#2c3444;
                          border-right-color:#2c3444;
                          border-top-color:#2c3444;
                          background:#2c3444; }

                          div.box-header {
                          text-align: center; }"

#####################################################################################

ui <- tagList(dashboardPage(
  skin = "green",
  dashboardHeader(title = "The Spotify Dashboard", titleWidth = '25vw'),
  
  dashboardSidebar(
    selectInput(
      "continents",
      label = "Region",
      choices = list(
        "North America" = "North America",
        "South America" = "South America",
        "Europe" = "Europe",
        "Asia" = "Asia",
        "Oceania" = "Australia",
        "Worldwide" = "Global"
      ),
      
      selected = "Global"
      
    ),
    
    fluidRow(column(12, uiOutput('countries'))),
    
    
    sidebarMenu(
      menuItem("1. Explanation", tabName = "overview"),
      menuItem("2. Correlation Analysis", tabName = "questions"),
      menuItem("3. Tendency", tabName = "Regquestions")
    )
    
  ),
  
  
  dashboardBody(
    tags$head(tags$style(HTML(mycss))),
    
    shinyDashboardThemes(theme = "grey_dark"),
    
  fluidRow(
    tabItems(tabItem(tabName = "overview", height = '30vw',
                     
                     #1st Page Text
                     fluidRow(column(12, style = 'padding-top: 25px;
                                 text-align: center', textOutput('box13'))),
                     
                     fluidRow(column(12, style = 'padding-top: 25px;
                                 padding-left: 50px;
                                 text-align: left', textOutput("box14"))),
                     
                     fluidRow(column(12, style = 'padding-top: 25px;padding-left: 50px;
                                 padding-left: 50px;
                                 text-align: left', textOutput("box15"))),
                     
                     fluidRow(column(12, style = 'padding-top: 25px;
                                 padding-left: 50px;
                                 text-align: left', textOutput("box16"))),
                     
                     fluidRow(column(12, style = 'padding-top: 25px;
                                 padding-left: 50px;
                                 padding-right: 45px;
                                 text-align: left', textOutput("box17"))),
                     
                     fluidRow(column(12, style = 'padding-top: 25px;
                                 padding-left: 50px;
                                 padding-right: 45px;
                                 text-align: left', textOutput("box18"))),
                     
                     fluidRow(column(12, style = 'padding-top: 25px;
                                 padding-bottom: 25px;
                                 padding-left: 50px;
                                 padding-right: 45px;
                                 text-align: left', textOutput("box19"))),
                     
              
              tags$head(tags$style(HTML(box_background_gray))),
              
              column(12,
                fluidRow(tabBox(# The id lets us use input$tabset1 on the server to find the current tab
                           id = "tabset1",
                           width = 12,
                           tabPanel("Acousticness", fluidRow(class = 'myRow1',
                                                              column(12,"A confidence measure from 0.0 to 1.0 of whether the track is acoustic. 1.0 represents high confidence the track is acoustic.",
                                                                     style = 'padding-top: 2vw;
                                                                              padding-left: 25px;
                                                                              padding-right: 25px;'),
                    
                    column(6,
                            style = 'padding-top: 50px;',
                            align = 'center',
                            offset = 3,
                            box(title =  "Most common value",
                                status = 'primary',
                                solidHeader = TRUE,
                                width = 10,
                                textOutput('box3'))
                      
                      
                    )
                  )),
                  
                  tabPanel("Duration [s]", fluidRow(
                    column(12, "Duration of the track in seconds.",
                           style = 'padding-top: 2vw;
                                    padding-left: 25px;
                                    padding-right: 25px;'),
                    
                    column(6,
                           style = 'padding-top: 50px;',
                           align = 'center',
                           offset = 3,
                           box(title =  "Most common value",
                               status = 'primary',
                               solidHeader = TRUE,
                               width = 10,
                               textOutput('box10'))
                           )
                  )),
                  
                  tabPanel("Energy", fluidRow(
                    column(
                      12,
                      "Energy is a measure from 0.0 to 1.0 and represents a perceptual measure of intensity and activity. Typically, energetic tracks feel fast, loud, and noisy. For example, death metal has high energy, while a Bach prelude scores low on the scale. Perceptual features contributing to this attribute include dynamic range, perceived loudness, timbre, onset rate, and general entropy.",
                      style = 'padding-top: 2vw;
                               padding-left: 25px;
                               padding-right: 25px;'),
                    
                    column(6,
                           style = 'padding-top: 50px;',
                           align = 'center',
                           offset = 3,
                           box(title =  "Most common value",
                               status = 'primary',
                               solidHeader = TRUE,
                               width = 10,
                               textOutput('box9'))
                    )
                  )),
                  
                  tabPanel("Instrumentalness", fluidRow(
                    column(
                      12,
                      "Predicts whether a track contains no vocals. 'Ooh' and 'aah' sounds are treated as instrumental in this context. Rap or spoken word tracks are clearly 'vocal'. The closer the instrumentalness value is to 1.0, the greater likelihood the track contains no vocal content. Values above 0.5 are intended to represent instrumental tracks, but confidence is higher as the value approaches 1.0.",
                      style = 'padding-top: 2vw;
                               padding-left: 25px;
                               padding-right: 25px;'),
                    
                    column(6,
                           style = 'padding-top: 50px;',
                           align = 'center',
                           offset = 3,
                           box(title =  "Most common value",
                               status = 'primary',
                               solidHeader = TRUE,
                               width = 10,
                               textOutput('box5'))
                    )
                  )),
                  
                  tabPanel("Liveness", fluidRow(
                    column(
                      12,
                      "Detects the presence of an audience in the recording. Higher liveness values represent an increased probability that the track was performed live. A value above 0.8 provides strong likelihood that the track is live.",
                      style = 'padding-top: 2vw;
                               padding-left: 25px;
                               padding-right: 25px;'),
                    
                    column(6,
                           style = 'padding-top: 50px;',
                           align = 'center',
                           offset = 3,
                           box(title =  "Most common value",
                               status = 'primary',
                               solidHeader = TRUE,
                               width = 10,
                               textOutput('box6'))
                    )
                  )),
                  
                  tabPanel("Loudness", fluidRow(
                    column(
                      12,
                      "The overall loudness of a track in decibels (dB). Loudness values are averaged across the entire track and are useful for comparing relative loudness of tracks. Loudness is the quality of a sound that is the primary psychological correlate of physical strength (amplitude). Values typical range between -60 and 0 db.",
                      style = 'padding-top: 2vw;
                               padding-left: 25px;
                               padding-right: 25px;'),
                    
                    column(6,
                           style = 'padding-top: 50px;',
                           align = 'center',
                           offset = 3,
                           box(title =  "Most common value",
                               status = 'primary',
                               solidHeader = TRUE,
                               width = 10,
                               textOutput('box11'))
                    )
                  )),
                  
                  tabPanel("Speechiness", fluidRow(
                    column(
                      12,
                      "It detects the presence of spoken words in a track. The more exclusively speech-like the recording (e.g. talk show, audio book, poetry), the closer to 1.0 the attribute value. Values above 0.66 describe tracks that are probably made entirely of spoken words. Values between 0.33 and 0.66 describe tracks that may contain both music and speech, either in sections or layered, including such cases as rap music. Values below 0.33 most likely represent music and other non-speech-like tracks.",
                      style = 'padding-top: 2vw;
                               padding-left: 25px;
                               padding-right: 25px;'),
                    
                    column(6,
                           style = 'padding-top: 50px;',
                           align = 'center',
                           offset = 3,
                           box(title =  "Most common value",
                               status = 'primary',
                               solidHeader = TRUE,
                               width = 10,
                               textOutput('box7'))
                    )
                  )),
                  
                  tabPanel("Tempo", fluidRow(
                    column(
                      12,
                      "The overall estimated tempo of a track in beats per minute (BPM). In musical terminology, tempo is the speed or pace of a given piece and derives directly from the average beat duration.",
                      style = 'padding-top: 2vw;
                               padding-left: 25px;
                               padding-right: 25px;'),
                    
                    column(6,
                           style = 'padding-top: 40px;',
                           align = 'center',
                           offset = 3,
                           box(title =  "Most common value",
                               status = 'primary',
                               solidHeader = TRUE,
                               width = 10,
                               textOutput('box8'))
                    )
                  )),
                  
                  tabPanel("Mode", fluidRow(
                    column(
                      12,
                      "Mode indicates the modality (major or minor) of a track, the type of scale from which its melodic content is derived. Major is represented by 1 and minor is 0.",
                      style = 'padding-top: 2vw;
                               padding-left: 25px;
                               padding-right: 25px;'),
                    
                    column(6,
                           style = 'padding-top: 50px;',
                           align = 'center',
                           offset = 3,
                           box(title =  "Most common value",
                               status = 'primary',
                               solidHeader = TRUE,
                               width = 10,
                               textOutput('box12'))
                    )
                  ))
                )
              )
            )
              
          ), 
      
      ## GENERAL QUESTIONS ###########################################################################
      
      tabItem(tabName =  "questions",
              
              fluidRow(
                
                fluidRow(column(12, style = 'padding-top: 25px;
                                             padding-bottom: 25px;
                                             text-align: center;', textOutput('box20'))),
                
                fluidRow(column(12, align= 'center', style = 'padding-bottom: 25px;
                                                              padding-left: 25px;
                                                              padding-right: 25px;', 
                                plotOutput("heatmap", click = "plot_click", width = '75%'))),
                
                column(12, fluidRow(tabBox(id = "tabset2", width = 12,
                                           tabPanel('Strong Positive Correlation', fluidRow(column(12, align = 'center',
                                                                                                   plotOutput("corr", click = "plot_click", width = '75%')))),
                                           
                                           
                                           
                                           tabPanel('Moderate Positive Correlation', fluidRow(class = 'text-center', column(3,
                                                                                                     plotOutput("m_corr", click = "plot_click")),
                                                                                                     
                                                                                              column(3,
                                                                                                     plotOutput("m_corr2", click = "plot_click")),
                                                                                                     
                                                                                              column(3,
                                                                                                     plotOutput("m_corr3", click = "plot_click")),
                                                                                                     
                                                                                              column(3,
                                                                                                     plotOutput("m_corr4", click = "plot_click")))),
                                                    
                                           
                                           
                                           
                                           tabPanel('Moderate Negative Correlation', fluidRow(class = 'center', column(4,
                                                                                                     plotOutput("mn_corr", click = "plot_click")),
                                                                                              
                                                                                              column(4,
                                                                                                     plotOutput("mn_corr2", click = "plot_click")),
                                                                                              
                                                                                              column(4,
                                                                                                     plotOutput("mn_corr3", click = "plot_click")))),
                                           
                                           
                                           
                                           
                                           tabPanel('Strong Negative Correlation', fluidRow(align = 'center', column(6,
                                                                                                   plotOutput("neg_corr", click = "plot_click")),
                                                                                            
                                                                                            column(6,
                                                                                                   plotOutput("neg_corr2", click = "plot_click"))))
                                           ) #tabBox
                                    ) #fluidRow
                       ), #column
                
                
                
                )  #fluidRow
              ), #tabItem
      
      
      
      
      
      
      ################################################################################################
      
      ## REGIONAL ANALYSIS
      tabItem(tabName = "Regquestions",
              
              fluidRow(column(12, style = 'padding-top: 25px;
                                             padding-bottom: 25px;
                                             padding-left: 25px;
                                             padding.right: 25px;
                                             text-align: center;', textOutput('box21'))),
              
              fluidRow(
                column(
                  12,
                  div(id = 'clickdiv',
                      valueBoxOutput("box1", width = 6)),
                  div(id = 'clickdiv2',
                      valueBoxOutput("box2", width = 6)),
                  style = 'padding: 10px'
                ),
                
                setShadow(id = "box1"),
                setShadow(id = "box2"),
                
                
                bsModal(
                  "artists",
                  "Artists on this region",
                  "clickdiv",
                  size = "large",
                  simpleNetworkOutput("force")
                ),
                bsModal(
                  "songs",
                  "Songs on this region",
                  "clickdiv2",
                  size = "large",
                  fluidRow(
                    column(12,
                           dataTableOutput('table1')))
                ),
                
                
                
                
                
                fluidRow(column(4, style = 'padding-top: 25px;
                                            padding-bottom: 25px;
                                            padding-left: 50px;
                                            padding-right: 50px;
                                            ',
                                  plotOutput("r_energy", click = "plot_click")),
                         
                         column(4, style = 'padding-top: 25px;
                                            padding-bottom: 25px;
                                            padding-left: 50px;
                                            padding-right: 50px;',
                                  plotOutput("r_acousticness", click = "plot_click")),
                         
                         column(4, style = 'padding-top: 25px;
                                            padding-bottom: 25px;
                                            padding-right: 50px;
                                            padding-left: 50px;',
                                  plotOutput("r_loudness", click = "plot_click"))),

                fluidRow(column(6, style = 'padding-top: 25px;
                                            padding-bottom: 25px;
                                            padding-left: 50px;
                                            padding-right: 50px;',
                                  plotOutput("r_danceability", click = "plot_click")),
                         
                         column(6, style = 'padding-top: 25px;
                                            padding-bottom: 25px;
                                            padding-right: 50px;
                                            padding-left: 50px;',
                                  plotOutput("r_tempo", click = "plot_click")))
                
                
              ))
      
      
    ) #tabItems
  ) #fluidRow
  )#dashboardBody
  )#dashBoardPage
  )#tagList


server <- function(input, output) {

  df <- merged_dfs
  
  data <- reactive({
    # Creates the dynamic data
    df %>%                  # Filter years, seasons & gender
      filter(continent %in% input$continents)
  })
  
  
  data2 <- reactive({
    # Creates the dynamic data
    df %>%                  # Filter years, seasons & gender
      filter(country %in% input$countries,
             continent %in% input$continents)
  })
  
  data3 <- reactive({
    # Creates the dynamic data
    df %>%                  # Filter years, seasons & gender
      filter(country %in% input$countries)
  })
  
  
  output$countries = renderUI({
    link = input$continents
    
    if(link == 'Europe'){
      
      sub1 <- merged_dfs %>% select(continent, country)
      sub1 <- na.omit(sub1)
      sub2 <- sub1[with(sub1, order(continent)),]
      sub2 <- sub2 %>% select(continent, country)
      sub3 <- sub2[with(sub2, order(country)),]
      sub4 <- distinct(sub3)
      sub4 <- sub4 %>% filter(grepl('Europe', continent))
      li_co <- c(sub4$country)
      li_co
      
    } else if (link == 'South America'){
        
      sub1 <- merged_dfs %>% select(rank, continent, country, energy, acousticness, loudness, danceability, tempo)
      sub1 <- na.omit(sub1)
      sub2 <- sub1[with(sub1, order(continent)),]
      sub2 <- sub2 %>% select(continent, country)
      sub3 <- sub2[with(sub2, order(country)),]
      sub4 <- distinct(sub3)
      sub4 <- sub4 %>% filter(grepl('South America', continent))
      li_co <- c(sub4$country)
      li_co
      
    } else if (link == 'North America'){
      sub1 <- merged_dfs %>% select(continent, country)
      sub1 <- na.omit(sub1)
      sub2 <- sub1[with(sub1, order(continent)),]
      sub2 <- sub2 %>% select(continent, country)
      sub3 <- sub2[with(sub2, order(country)),]
      sub4 <- distinct(sub3)
      sub4 <- sub4 %>% filter(grepl('North America', continent))
      li_co <- c(sub4$country)
      li_co
    
      } else if (link == 'Australia'){
        sub1 <- merged_dfs %>% select(continent, country)
        sub1 <- na.omit(sub1)
        sub2 <- sub1[with(sub1, order(continent)),]
        sub2 <- sub2 %>% select(continent, country)
        sub3 <- sub2[with(sub2, order(country)),]
        sub4 <- distinct(sub3)
        sub4 <- sub4 %>% filter(grepl('Australia', continent))
        li_co <- c(sub4$country)
        li_co
        
        } else if (link == 'Asia'){
        sub1 <- merged_dfs %>% select(continent, country)
        sub1 <- na.omit(sub1)
        sub2 <- sub1[with(sub1, order(continent)),]
        sub2 <- sub2 %>% select(continent, country)
        sub3 <- sub2[with(sub2, order(country)),]
        sub4 <- distinct(sub3)
        sub4 <- sub4 %>% filter(grepl('Asia', continent))
        li_co <- c(sub4$country)
        li_co
        
        } else if (link == 'Global') {
        sub1 <- merged_dfs %>% select(continent, country)
        sub1 <- na.omit(sub1)
        sub2 <- sub1[with(sub1, order(continent)),]
        sub2 <- sub2 %>% select(continent, country)
        sub3 <- sub2[with(sub2, order(country)),]
        sub4 <- distinct(sub3)
        sub4 <- sub4 %>% filter(grepl('Global', continent))
        li_co <- c(sub4$country)
        li_co }
    
    
    selectInput('countries', 'Country', li_co)
  })
  
  
  
  # MODE FUNCTION
  Mode <- function(a) {
    ux = unique(a)
    x = length(a)
    tab <- tabulate(match(x, ux))
    ux[which.max(tab == max(tab))]
  }
  
  output$box1 <- renderValueBox({
    valueBox(value = NROW(unique(data2()$artists)),
             subtitle =  "# of artists in this region",
             color = "green")
  })
  
  output$table <- renderDataTable({
    unique(subset(data2(), select = artists))
  })
  
  output$table1 <- renderDataTable({
    unique(subset(data2(), select = c(title, rank, artists)))
  })
  
  output$box2 <- renderValueBox({
    valueBox(
      value = length(unique(na.omit(data2()$title))),
      subtitle =  "# of songs in this region",
      color = "green"
    )
  })
  
  output$box3 <- renderText(
    Mode(data2()$acousticness)
    )
  
  output$box4 <- renderText(
    Mode(data2()$danceability)
    )
  
  output$box5 <- renderText(
    Mode(data2()$instrumentalness)
    )
  
  output$box6 <- renderText(
    Mode(data2()$liveness)
    )
  
  
  output$box7 <- renderText(
    Mode(data2()$speechiness)
    )
  
  output$box8 <- renderText(
    paste(Mode(data2()$tempo), "BPM")
    )
  
  
  output$box9 <- renderText(
    Mode(data2()$energy)
  )
  
  
  
  output$box10 <- renderText(
    paste(Mode(data2()$duration), "s")
  )
  
  
  output$box11 <- renderText(
    paste(Mode(data2()$loudness), " dB")
  )
  
  
  output$box12 <- renderText(
    paste(Mode(data2()$mode))
  )
  
  output$box13 <- renderText(
    "CONTENT"
 )
  
  output$box14 <- renderText(
    "Page 1. Explanation: Analyzed variables' explanation."
  )
  
  output$box15 <- renderText(
    "Page 2. Correlation Analysis: Variables that change per region."
  )
  
  output$box16 <- renderText(
    "Page 3. Correlated Variables' Tendency: Variables that change by region and country."
  )
  
  output$box18 <- renderText(
    "Please refer to the striped button located at the upper-left corner of the window to find the different pages on this dashboard."
  )

  output$box20 <- renderText(
    "ARE THESE VARIABLES CORRELATED?"
  )
  
  output$box21 <- renderText(
    "CAN WE SEE A TENDENCY OF THESE VARIABLES WHEN WE COMPARE THEM TO RANKED SONGS? (TOP 50)"
  )
  
  
  
  output$heatmap <- renderPlot({
    numbers <- data() %>% select(acousticness:tempo)
    
    M <- cor(numbers)
    corrplot(
      M,
      type = "upper",
      method = 'number',
      order = "original",
      col = brewer.pal(n = 10, name = "RdYlGn"),
      number.cex = 7 / ncol(M),
      bg = 212121
    )
  })
  
  
  output$corr <- renderPlot({
    ggscatter(
      data(),
      x = "loudness",
      y = "energy",
      add = "reg.line",
      conf.int = TRUE,
      cor.coef = TRUE,
      cor.method = "pearson",
      xlab = "Loudness (dB)",
      ylab = "Energy"
    )
  })
  
  
  output$m_corr <- renderPlot({
    ggscatter(
      data(),
      x = "loudness",
      y = "danceability",
      add = "reg.line",
      conf.int = TRUE,
      cor.coef = TRUE,
      cor.method = "pearson",
      xlab = "Loudness (dB)",
      ylab = "Danceability"
    )
  })
  
  output$m_corr2 <- renderPlot({
    ggscatter(
      data(),
      x = "energy",
      y = "danceability",
      add = "reg.line",
      conf.int = TRUE,
      cor.coef = TRUE,
      cor.method = "pearson",
      xlab = "Energy",
      ylab = "Danceability"
    )
  })
  
  output$m_corr3 <- renderPlot({
    ggscatter(
      data(),
      x = "energy",
      y = "tempo",
      add = "reg.line",
      conf.int = TRUE,
      cor.coef = TRUE,
      cor.method = "pearson",
      xlab = "Energy",
      ylab = "Tempo (BPM)"
    )
  })
  
  
  output$m_corr4 <- renderPlot({
    ggscatter(
      data(),
      x = "loudness",
      y = "tempo",
      add = "reg.line",
      conf.int = TRUE,
      cor.coef = TRUE,
      cor.method = "pearson",
      xlab = "Loudness (dB)",
      ylab = "Tempo (BPM)"
    )
  })
  
  
  output$mn_corr <- renderPlot({
    ggscatter(
      data(),
      x = "acousticness",
      y = "danceability",
      add = "reg.line",
      conf.int = TRUE,
      cor.coef = TRUE,
      cor.method = "pearson",
      xlab = "Acousticness",
      ylab = "Danceability"
    )
  })
  
  
  output$mn_corr2 <- renderPlot({
    ggscatter(
      data(),
      x = "acousticness",
      y = "tempo",
      add = "reg.line",
      conf.int = TRUE,
      cor.coef = TRUE,
      cor.method = "pearson",
      xlab = "Acousticness",
      ylab = "Tempo (BPM)"
    )
  })
  
  
  output$mn_corr3 <- renderPlot({
    ggscatter(
      data(),
      x = "instrumentalness",
      y = "loudness",
      add = "reg.line",
      conf.int = TRUE,
      cor.coef = TRUE,
      cor.method = "pearson",
      xlab = "instrumentalness",
      ylab = "loudness"
    )
  })
  
  
  output$neg_corr <- renderPlot({
    ggscatter(
      data(),
      x = "acousticness",
      y = "energy",
      add = "reg.line",
      conf.int = TRUE,
      cor.coef = TRUE,
      cor.method = "pearson",
      xlab = "Acousticness",
      ylab = "Energy"
    )
  })
  
  
  output$neg_corr2 <- renderPlot({
    ggscatter(
      data(),
      x = "acousticness",
      y = "loudness",
      add = "reg.line",
      conf.int = TRUE,
      cor.coef = TRUE,
      cor.method = "pearson",
      xlab = "Acousticness",
      ylab = "Loudness (dB)"
    )
  })
  
  
  output$r_energy <- renderPlot({
    plot(data2()$rank, data2()$energy, main = "Energy VS Rank", ylab = 'Energy', xlab = 'Rank')
  })
  
  
  output$r_acousticness <- renderPlot({
    plot(data2()$rank, data2()$acousticness, main = "Acousticness VS Rank", ylab = 'Acousticness', xlab = 'Rank')
  })
  
  
  output$r_loudness <- renderPlot({
    plot(data2()$rank, data2()$acousticness, main = "Loudness VS Rank", ylab = 'Loudness', xlab = 'Rank')
  })
  
  output$r_danceability <- renderPlot({
    plot(data2()$rank, data2()$acousticness, main = "Danceability VS Rank", ylab = 'Danceability', xlab = 'Rank')
  })
  
  output$r_tempo <- renderPlot({
    plot(data2()$rank, data2()$acousticness, main = "Tempo VS Rank", ylab = 'Acousticness', xlab = 'Rank')
  })
  
  
  #####################################################################
  
  output$force <- renderSimpleNetwork({

    
    networkData <- data.frame(data2()$artist, data2()$country)
    simpleNetwork(
      networkData,
      nodeColour = '#1DB954',
      opacity = 1.0,
      linkDistance = 80,
      linkColour = "	#535353",
      zoom =  T,
      charge = -500,
      fontSize = 10
    )
  })
  
  
  
}

shinyApp(ui = ui, server = server)

