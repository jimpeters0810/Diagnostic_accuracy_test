#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(shinyjs)
library(riskyr)

ui <- navbarPage('E-learning diagnostic accuracy',
                 tabPanel('Background',
                          shinyUI(fluidPage(useShinyjs(),
                                            titlePanel('Self-study assignment: cancer diagnosis'),
                                            h4('Background'),
                                            p(
                                                'There are hundreds of questions about the use of diagnostic tests in clinical settings and many
researchers study these questions. Almost daily articles are published about a new test with a
certain diagnostic value for a specific disease. Often these tests were developed in the field of
molecular biology / clinical chemistry or medical physics (e.g. imaging techniques). The clinical
epidemiologist evaluates the added value of introducing these diagnostic tests into daily
practice. This self-study assignment consists of 3 parts. In part 1 you will calculate and interpret various measures of diagnostic accuracy yourself.
                                                            In part 2 you will use an interactive tool to learn more about the influence of disease prevalence on various
                                                            test properties and their interrelationship. Part 3 is an online practical assignment in which 
                                                            you will determine the diagnostic value of a continuous test using an ROCanalysis.'),
                                            br(),
                                            br(),
                                            img(src="Mammogram.png",align="center",height="600px",width="400px"),    
                          ))),
                 tabPanel('Part 1',
                                          shinyUI(fluidPage(useShinyjs(),
                                                            h4('Part 1: properties of a clinical test'),
                                                            p('In the following table you find the mammography results determined by a radiologist
(abnormal/normal) and the ultimate breast cancer diagnosis (present/absent) determined by a
pathologist with the gold standard: a biopsy. The population consists of patients who were referred to the hospital to further evaluate a suspicion of breast cancer.'),
                                                            img(src='Tabel1.png',height='200px',width='750px',align='center'),
                                                            p('The goal is to determine whether mammography is a relevant diagnostic test to detect breast cancer.'),
                                                            p('1.   Look for information regarding terms/concepts with which you can express the diagnostic
value of a test (for example: sensitivity, false positive/negative, etc.).'),
                                                            actionButton("button","Show suggestions"),
                                                            hidden(
                                                                div(id="text_div",
                                                                    verbatimTextOutput("text"))
                                                            ),
                                                            p('2.   Apply these terms/concepts to the table depicted above and calculate these values'),
                                                            actionButton("button2", "Show answer"),
                                                            hidden(
                                                                div(id='text_div2',
                                                                    verbatimTextOutput("text2")
                                                                )
                                                            ),
                                                            p('3.   What is your conclusion? Considering the test characteristics you calculated above, is
mammography a relevant diagnostic test to detect breast cancer?'),
                                                            actionButton("button3","Show answer"),
                                                            hidden(
                                                                div(id="text_div3",
                                                                    verbatimTextOutput("text3"))
                                                            )))),
                 tabPanel('Part 2',
                          fluidPage(
                              fluidRow(
                                  h4("Part 2: Evaluating a diagnostic test in different settings")
                                  ),
                              fluidRow(column(4,
                                                      
                                                      numericInput("N",label = "Population size:",
                                                                   min=0, max = 1000000,value = 725000),
                                                      
                                                      
                                                      sliderInput("prev", 
                                                                  label = "Prevalence:",
                                                                  min = 0, max = 100, value = 50,step = 0.5),
                                                      
                                                      sliderInput("sens", 
                                                                  label = "Sensitivity:",
                                                                  min = 0, max = 100, value = 50),
                                                      
                                                      sliderInput("spec", 
                                                                  label = "Specificity:",
                                                                  min = 0, max = 100, value = 50)),
                                       column(8,
                                              tabsetPanel(
                                                  tabPanel("Tree plot", plotOutput("treeplot")),
                                                  tabPanel("PPV/NPV curves", plotOutput("curveplot")),
                                                  tabPanel("Other values", textOutput("PLR"),
                                                           textOutput("NLR"),
                                                           textOutput("DOR"))),
                                              helpText("",span(HTML("<b>Instructions</b>")),": Use the box on the left to pick a size for your population and use the drawbars to change the prevalence of the disease in that population as well as the sensitivity and specificity of the test. Observe the changes in the tree plot and probability curves. 
                     Make sure you understand which values in the tree plot represent true/false positives and true/false negatives.
                     In the probability plot you will find the positive and negative predictive values (PPV and NPV). Lastly,
                     likelihood ratios and diagnostic odds ratio are given (under 'other values')."),
                                              )),
                              fluidRow(
            h4("Questions"),
            p("4.	In the Netherlands you could speak of a ‘breast cancer epidemic’. There have been many efforts to reduce breast cancer mortality, for example early detection with mammography screening. During MGZ – Neoplasma: Populatie you have looked at the frequency of many different cancers in the SSA ‘Dokter, wat is de kans dat ik kanker krijg?’. Review this assignment and determine the magnitude of the ‘breast cancer epidemic’ in the Netherlands."),
            actionButton("button4","Show answer"),
            hidden(
                div(id="text_div4",
                    verbatimTextOutput("text4"))
            ),
            p("In the next few questions, you will be using an interactive tool (see above) to learn more about the performance of a diagnostic test in different settings. In this tool,
                                                              two figures are presented that provide information about the accuracy of your test in different scenarios (which you can adjust). Play around with this tool and make sure you understand
                                                              the figures before moving on to the next few questions."),
            p("5.   For this question use the interactive tool and look at the tree plot. Assume that both the sensitivity and the specificity of the 1st screening for women older than 50 years is 93%, whereby the underlying prevalence of breast cancer at first screening is 1% (for the ease of this exercise, in reality this is slightly lower). How many women will get a false positive or false negative screening result, respectively, when 725,000 women (which is equal to the annual target population between the ages of 50-74 years) are screened? What do you think of this result?"),
            actionButton("button5","Show answer"),
            hidden(
                div(id="text_div5",
                    verbatimTextOutput("text5"))
            ),
            p("Remember from the lecture that screening targets",
              span(HTML("<b>asymptomatic</b>")), "persons, while a clinical test is intended for those with a clinical suspicion of disease. If we would only look at a population of persons with a suspicion of disease, it is not hard to imagine that the prevalence of that disease is higher in such a selected population."),
            p("6.   Go back to the interactive tool. Using the drawbars on the left, increase the prevalence from 1% to 27% (the prevalence calculated in the previous assignment). Look at all the values that describe the value of this diagnostic test and describe (in terms of increase/decrease) how they have changed after you increased the prevalence"),
            actionButton("button6","Show answer"),
            hidden(
                div(id="text_div6",
                    verbatimTextOutput("text6"))
            ),
            p("7.	In words, we could define sensitivity as, ",span(HTML("<em>‘the probability of a positive test result, given that someone has the disease’</em>")),". In similar fashion, provide definitions for specificity as well as positive and negative predictive value. Based on these definitions, explain why some values are influenced by a change in prevalence, while others are not (as you saw in the previous question)."),
            actionButton("button7","Show answer"),
            hidden(
                div(id="text_div7",
                    verbatimTextOutput("text7"))
            ),
            p("8.  With above definitions in mind, try to think what would happen to other values if you lower sensitivity (e.g. from 93 to 73%). Then, try this with the interactive tool and describe your findings. Repeat this, but now after lowering specificity."),
            actionButton("button8","Show answer"),
            hidden(
                div(id="text_div8",
                    verbatimTextOutput("text8")))))),
        tabPanel("Part 3",
         fluidPage(
             h4("Part 3: assessing mammograms and evaluating ROC curves"),
             p("We have collected 25 mammograms from the national screening program. On a number of mammograms a malignant tumor is visible, which can be identified by a more or less round, white density (shadow or mass) with at times non-delineated edges but sometimes also spiculae. The white dots visible on some of the mammograms represent calcifications, these may indicate the presence of a cancer."),
             p("Start the online program by clicking ",tags$a(href="http://ebh-webeducation.ruhosting.nl/ROC-Curves/","this link"),"and look at the introductory pictures."),
             p("Rate each of the mammograms on a scale of 0 to 10, indicating how certain you are that a carcinoma is present. A 10 means that you are completely certain that there is a carcinoma present on the mammogram; 9 indicates you are less certain; …. 5, you are unsure either way; … ; you are almost certain there is no carcinoma on the mammogram, and 0 you are absolutely sure that there is no carcinoma present on the mammogram."),
             p("9.	Compare your scores to the true diagnoses of cancer (Overzicht scores 1, resultaat). How did you score?"),
             p("10.	Reflect on your scoring performance. To obtain a perfect score you had to score '10' 12 times and '0' 13 times."),
             p("11.	Now you are able to determine the sensitivity and the percentage false positives (i.e. 100%-specificity) by using the scores (overzicht 2) for each cut-off point of certainty. Check this in the tab ‘afkappunten’ (overzicht scores 3). Check if you are able to reproduce these values. If for example ‘zekerheid = 8’ is selected as the criterion for a positive result, then someone with a score of 8 or higher would have had a positive screening result."),
             p("12.	Now all the possible combinations of sensitivity and percentage false positives (100%-specificity) can be plotted in a graph and connected with a line. This will create the so called ROC-curve. The AUC (= area under the curve) of the ROC-curve is a measure of the diagnostic performance of a test. How do you interpret the ROC-curve?"),
             actionButton("button9","Show answer"),
             hidden(
                 div(id="text_div9",
                     verbatimTextOutput("text9"))
             ),
             p("13.	Think of 4 factors that could influence the magnitude of the AUC."),
             actionButton("button10","Show answer"),
             hidden(
                 div(id="text_div10",
                     verbatimTextOutput("text10"))
             ),
             p("14.	Review the table ‘Afkappunten’ (Overzicht scores 3).Choose a cut-off value above which you would be willing to refer a woman for a biopsy. Next, create a cross table in which you present ‘refer for biopsy yes/no’ against ‘carcinoma yes/no’. Afterwards use this table to determine the following items:"),
             p("a.	Prior probability (prevalence) of breast cancer",
               br(),"b.	Percentage biopsies with your chosen cut-off value",
               br(),"c.	Percentage false positive results",
               br(),"d.	Percentage false negative results",
               br(),"e.	Sensitivity",
               br(),"f.	Specificity",
               br(),"g.	Positive likelihood ratio of the screening test",
               br(),"h.	Positive predictive value (PPV)",
               br(),"i.	Diagnostic odds ratio"),
             actionButton("button11","Show answer"),
             hidden(
                 div(id="text_div11",
                     verbatimTextOutput("text11"))
             ),
             p("15.	What consequences do the choice of cut-off value have for the number of false positive and false negative screening results, respectively?  Additionally, what are the consequences for the woman?"),
             actionButton("button12","Show answer"),
             hidden(
                 div(id="text_div12",
                     verbatimTextOutput("text12"))
                 ),
             h4("Example of cross table for a given cut-off point (question 14)"),
             p("The answer depends on how you scored the mammograms and which cut-off value you picked. The pictures and table below provide an example of how your answer could look like."),
             img(src="Resultaten.png",align="center",height="300px",width="450px"),
             img(src="Afkappunten.png",align="center",height="300px",width="450px"),
             img(src="ROCplot.png",align="center",height="300px",width="450px"),
             p("",span(HTML("The table and measures of diagnostic accuracy below are based on a cut-off value of 6 (Check this with the ROC curve!)")),":"),
             img(src="Tabel.png",align="center",height="350px",width="350px")
         )))

server <- function(input, output,session) {
    
    observeEvent(input$button, {
        toggle("text_div")
        output$text <- renderText({"You may think about the following terms and concepts:
            
- False positives, false negatives, true positives, true negatives
- Prevalence
- Sensitivity, Specificity, Positive predictive value, Negative predictive value
- Positive likelihood ratio, Negative likelihood ratio, Diagnostic odds ratio"
        })
    })
    
    observeEvent(input$button2, {
        toggle('text_div2')
        output$text2 <- renderText({"- Number of persons with false positive (FP) mammogram: 21
- Number of persons with false negative (FN) mammogram: 38
- Number of persons with true positive (TP) mammogram: 114
- Number of persons with true negative (TN) mammogram: 382
- Prior probability (prevalence) = 152/555 = 27.4%
- Sensitivity = 114/152 = 75%
- Specificity = 382/403 = 95%
- Positive likelihood ratio = 75%/5% = 15
- Negative likelihood ratio = 25%/95% = 0.26
- Diagnostic odds ratio: (114*382)/(38*21) = 54.6
- Positive predictive value = 114/135 = 84%
- Negative predictive value =382/420 = 91%"})
    })
    
    observeEvent(input$button3, {
        toggle("text_div3")
        output$text3 <- renderText({"The test has a good diagnostic value. However, important mistakes are made.
For a clinical test, specificity is acceptable, but sensitivity is too low. 
You would need  an additional test to diagnose the disease. Improvement is necessary."})
    })
    
    observeEvent(input$button4, {
        toggle("text_div4")
        output$text4 <- renderText({"In 2018, 14,616 new cases of invasive breast cancer were diagnosed, next to 2,221 new cases of ductal carcinoma in situ (DCIS).
3,059 women died of the disease."})
    })
    
    observeEvent(input$button5, {
        toggle("text_div5")
        output$text5 <- renderText({"Although a sensitivity and specificity of both 93% seems high, it’s the specificity that would be too low for screening. 
In this population, screening would yield only 508 false negative results, but as much as 50,242 false positives, which is extortionate."})
    })
    
    observeEvent(input$button6, {
        toggle("text_div6")
        output$text6 <- renderText({"- TP increased, FP decreased, TN decreased, FN increased
- Positive predictive value increased, negative predictive value decreased
- Sensitivity/specificity/LR+/LR-/DOR remained the same"})
    })
    
    observeEvent(input$button7, {
        toggle("text_div7")
        output$text7 <- renderText({"Speficity: ‘the probability of a negative test result, given that someone does not have the disease’ 
PPV: ‘the probability of having the disease, given that someone has a positive test result’ 
NPV: ‘the probability of not having the disease, given that someone has a negative test result’
Only PPV and NPV are influenced by prevalence of the disease, as they are calculated by making use of both diseased and non-diseased persons. 
Hence, PPV and NPV describe the performance of a test, subject to the prevalence of disease in the population where the test is used. 
Sensitivity is calculated based on diseased persons only, and specificity based on non-diseased persons. Thus, these measures are not affected by disease prevalence."})
    })
    
    observeEvent(input$button8, {
        toggle("text_div8")
        output$text8 <- renderText({"When lowering sensitivity: 
        - TP decreases, FP increases, TN and FN remain unchanged
        - PPV and NPV both decrease
        - PLR decreases, NLR increases, DOR decreases
When lowering specificity:
        - TP and FP remain unchanged, TN decreases, FN increases
        - PPV and NPV both decrease
        - PLR increases, NLR decreases, DOR decreases"})
    })
    
    observeEvent(input$button9, {
        toggle("text_div9")
        output$text9 <- renderText({"If the AUC is equal to 0.5 then the test would be the equivalent of flipping a coin to decide whether someone has cancer. 
If the AUC is high, (i.e. higher than 0.8), the test has relatively good diagnostic value."})
    })
    
    observeEvent(input$button10, {
        toggle("text_div10")
        output$text10 <- renderText({"Quality of the mammogram (compression, light, positioning technique), density of glandular tissue, 
experience of the radiologist/reader, prevalence of breast cancer in the population (if you only detect cancer in 7 out of  1000 mammograms then you may miss cancers which you would have been able to detect if the prevalence were 50%),
tumor size (in a clinical setting you encounter more larger tumors, with screening you detect many smaller tumors)."})
    })
    
    observeEvent(input$button11, {
        toggle("text_div11")
        output$text11 <- renderText({"Answer depends on individual mammography assessments and chosen cut-off values. See the end of this e-learning for an example"})
    })
    
    observeEvent(input$button12, {
        toggle("text_div12")
        output$text12 <- renderText({"A low cut-off value: a lot of false positives and thus many unnecessary biopsies. But also fewer false negatives.
A high cut-off value: low number of false positives and unnecessary biopsies. but more false negatives.
In summary, the choice of cut-off value depends on the situation. 
In the clinic, where women present with complaints, you could opt for a high sensitivity and thus more false positives. 
For screening, with  almost 1,000,000 mammograms annually, the emphasis will be on a high specificity, resulting in a higher percentage of false negatives."})
    })
    
    output$treeplot <- renderPlot({plot_prism(N = input$N,
                                              prev = input$prev/100,
                                              sens = input$sens/100,
                                              spec = input$spec/100,
                                              by = "dc",
                                              mar_notes=FALSE,
                                              p_lbl="no",
                                              f_lbl="namnum",
                                              lbl_txt = init_txt(scen_lbl = "Breast cancer diagnosis",
                                                                 popu_lbl = "Source population",
                                                                 cond_lbl = "Breast cancer",
                                                                 cond_true_lbl = "Diagnosis of breast cancer",
                                                                 cond_false_lbl = "No breast cancer",
                                                                 dec_lbl = "Mammography result",
                                                                 dec_pos_lbl = "Positive test",
                                                                 dec_neg_lbl = "Negative test",
                                                                 hi_lbl = "Cancer",
                                                                 mi_lbl = "Cancer",
                                                                 fa_lbl = "No cancer",
                                                                 cr_lbl = "No cancer"),
                                              title_lbl = "",
                                              cex_lbl = 0.95)
        })
    
    output$curveplot <- renderPlot(plot_curve(prev = input$prev/100,
                                              sens = input$sens/100,
                                              spec = input$spec/100,
                                              mar_notes = FALSE,
                                              title_lbl = ""))
    
    output$PLR <- renderText({ 
        paste("Positieve Likelihood Ratio:", round(input$sens/(100-input$spec),digits=2),"%")
    })
    
    output$NLR <- renderText({ 
        paste("Negatieve Likelihood Ratio:", round((100-input$sens)/input$spec,digits=2),"%")
    })
    
    output$DOR <- renderText({ 
        paste("Diagnostische Odds Ratio:", round((input$sens/(100-input$spec))/((100-input$sens)/input$spec),digits=2))
    })
    
}

shinyApp(ui, server)