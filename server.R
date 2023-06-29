
library(shiny)

library(ExpImage)

shinyServer(
    function(input, output) {
        FILEURL <-
            reactive({
                fileUploaded <- input$THEFILE
                if (is.null(fileUploaded)) {
                    return(NULL)
                } else {
                    return(fileUploaded$datapath)
                }
            })

        DATASET <-
            reactive({
                fileurl <- isolate(FILEURL())
                input$RUN
                if (is.null(fileurl)) {
                    return(NULL)
                } else {
                    imagem <-
                        read_image(
                            fileurl
                        )
                    return(imagem)
                }
            })
        

        output$INFO_IMAGE <-
            renderPrint({
                if (is.null(DATASET())) {
                    cat("------------------------------------------------\n")
                    cat("Informações sobre a imagem\n")
                } else {
                    image_info(dataset = DATASET())
                }
            })

        output$PLOT_IMAGE <-
            renderPlot({
                if (is.null(DATASET())) {
                    NULL
                } else {
                    plot_imagem(dataset = DATASET())
                }
            })
        
        
        REDIMENSIONAR <-
            reactive({
                if (is.null(DATASET())) {
                    NULL
                } else {
                    rdm<-redimensionar(dataset = DATASET(), perc=input$PERC)
                    return(rdm)
    
                }
            })
        
        

        output$REDIMENS <-
            renderPlot({
                if (is.null(REDIMENSIONAR())) {
                    NULL
                } else {
                    plot_redm(dataset = REDIMENSIONAR(), resposta=input$REDIM)
                    
                    
                }
            })
        
        output$INFO_IMAGE_REDM <-
            renderPrint({
                if (is.null(REDIMENSIONAR())) {
                    cat("----------------------------------------------\n")
                    cat("Informações sobre a imagem redimensionada\n")
                } else {
                    image_info_red(dataset = REDIMENSIONAR(), resposta=input$REDIM)
                }
            })
        
        
        CORTAR<-
            reactive({
                if (is.null(DATASET())) {
                    NULL
                } 
                else {
                    corte<-corte_image(dataset= DATASET(),
                                h_min=input$ALTURA_MIN, h_max=input$ALTURA_MAX,
                                w_min=input$LARGURA_MIN, w_max=input$LARGURA_MAX, resposta=input$CORTAR)
                    return(corte)
                }
            })
       
        
        output$CORTAR_IM<-
            renderPlot({
                if (is.null(CORTAR())) {
                    NULL
                } else {
                    corte_image(dataset= REDIMENSIONAR(),
                                h_min=input$ALTURA_MIN, h_max=input$ALTURA_MAX,
                                w_min=input$LARGURA_MIN, w_max=input$LARGURA_MAX, resposta=input$CORTAR)
                }
            })


        output$INFO_IMAGE_CORT <-
            renderPrint({
                if (is.null(CORTAR())) {
                    cat("----------------------------------------------\n")
                    cat("Informações sobre a imagem cortada\n")
                } else {
                    image_info_cort(dataset = corte_image(dataset= REDIMENSIONAR(),
                                                          h_min=input$ALTURA_MIN, h_max=input$ALTURA_MAX,
                                                          w_min=input$LARGURA_MIN, w_max=input$LARGURA_MAX, 
                                                          resposta=input$CORTAR), resposta=input$CORTAR)
                }
            })


        output$PLOT_INDEX <-
            renderPlot({
                input$IMAGEM_FINAL
                isolate({
                if (is.null(DATASET())) {
                    NULL
                } else {
                    plot_index(dataset_corte_redm = corte_image(dataset= REDIMENSIONAR(),
                                                     h_min=input$ALTURA_MIN, h_max=input$ALTURA_MAX,
                                                     w_min=input$LARGURA_MIN, w_max=input$LARGURA_MAX, 
                                                     resposta=input$CORTAR), 
                               dataset_redim = REDIMENSIONAR(),
                               dataset_cortado = CORTAR(),
                               dataset_sem_edit= DATASET(),
                               
                               resposta_redm=input$REDIM, 
                               resposta_cortar=input$CORTAR)
                }
            })
        })
        
        #FUNDO:

        output$MASCARA_1 <-
            renderPlot({
                if (is.null(DATASET())) {
                    NULL
                } else {
                    plot_mask_1(dataset_corte_redm = corte_image(dataset= REDIMENSIONAR(),
                                                               h_min=input$ALTURA_MIN, h_max=input$ALTURA_MAX,
                                                               w_min=input$LARGURA_MIN, w_max=input$LARGURA_MAX, 
                                                               resposta=input$CORTAR), 
                              dataset_redim = REDIMENSIONAR(),
                              dataset_cortado = CORTAR(),
                              dataset_sem_edit= DATASET(),
                              
                              resposta_redm=input$REDIM, 
                              resposta_cortar=input$CORTAR,
                              
                              indice=input$INDICE_1, 
                              resposta_indice=input$INDEX_1)
                }
            })
        

        SEGMENTACAO_1 <-
            reactive({
                if (is.null(DATASET())) {
                    NULL
                } else {
                    segm_1<-plot_segment_1(dataset_corte_redm = corte_image(dataset= REDIMENSIONAR(),
                                                                         h_min=input$ALTURA_MIN, h_max=input$ALTURA_MAX,
                                                                         w_min=input$LARGURA_MIN, w_max=input$LARGURA_MAX, 
                                                                         resposta=input$CORTAR), 
                                        dataset_redim = REDIMENSIONAR(),
                                        dataset_cortado = CORTAR(),
                                        dataset_sem_edit= DATASET(),
                                        
                                        resposta_redm=input$REDIM, 
                                        resposta_cortar=input$CORTAR,
                                        
                                        indice=input$INDICE_1, 
                                        
                                       thr=input$THRESH_1, resposta_segment=input$SEGMENT_1,
                                        fillback=input$FILLBACK_1, fillhull=input$FILLHULL_1,
                                        selec_val=input$SELECTHIGHER_1)
                    
                    return(segm_1)
                }
            })
        
        output$SEGMENT_1 <-
            renderPlot({
                if (is.null(SEGMENTACAO_1())) {
                    NULL
                } else {
                    plot_segment2_1(dataset = SEGMENTACAO_1(), resposta_segment=input$SEGMENT_1)
                }
            })
        
        #àrea:
        
        output$MASCARA_2 <-
            renderPlot({
                if (is.null(SEGMENTACAO_1())) {
                    NULL
                } else {
                    plot_mask_2(dataset_corte_redm = corte_image(dataset= REDIMENSIONAR(),
                                                               h_min=input$ALTURA_MIN, h_max=input$ALTURA_MAX,
                                                               w_min=input$LARGURA_MIN, w_max=input$LARGURA_MAX, 
                                                               resposta=input$CORTAR), 
                              dataset_redim = REDIMENSIONAR(),
                              dataset_cortado = CORTAR(),
                              dataset_sem_edit= DATASET(),
                              
                              resposta_redm=input$REDIM, 
                              resposta_cortar=input$CORTAR,
                              
                              indice=input$INDICE_2, 
                              resposta_indice=input$INDEX_2)
                }
            })
        
        
        SEGMENTACAO_2 <-
            reactive({
                if (is.null(DATASET())) {
                    NULL
                } else {
                    segm_2<-plot_segment_2(dataset_corte_redm = corte_image(dataset= REDIMENSIONAR(),
                                                                            h_min=input$ALTURA_MIN, h_max=input$ALTURA_MAX,
                                                                            w_min=input$LARGURA_MIN, w_max=input$LARGURA_MAX, 
                                                                            resposta=input$CORTAR), 
                                           dataset_redim = REDIMENSIONAR(),
                                           dataset_cortado = CORTAR(),
                                           dataset_sem_edit= DATASET(),
                                           
                                           resposta_redm=input$REDIM, 
                                           resposta_cortar=input$CORTAR,
                                           
                                           indice=input$INDICE_2, 
                                           
                                           thr=input$THRESH_2, resposta_segment=input$SEGMENT_2,
                                           fillback=input$FILLBACK_2, fillhull=input$FILLHULL_2,
                                           selec_val=input$SELECTHIGHER_2)
                    
                    return(segm_2)
                }
            })
        
        output$SEGMENT_2 <-
            renderPlot({
                if (is.null(SEGMENTACAO_2())) {
                    NULL
                } else {
                    plot_segment2_2(dataset = SEGMENTACAO_2(), resposta_segment=input$SEGMENT_2)
                }
            })
        
        output$PERCENTAGEM <-
            renderPrint({
                input$PERCENTAGEM
                isolate({
                if (is.null(SEGMENTACAO_2())) {
                    cat("------------------------------------------------\n")
                    cat("Percentagem da área segmentada\n")
                } else {
                    percentagem(fundo=SEGMENTACAO_1(), area= SEGMENTACAO_2())
                }
            })
            })
        
        
        PLOT_IMAGEM_FINAL <-
            reactive({
                if (is.null(SEGMENTACAO_2())) {
                    NULL
                } else {
                    plot_im_final<-plot_im_final(dataset_corte_redm = corte_image(dataset= REDIMENSIONAR(),
                                                                                      h_min=input$ALTURA_MIN, h_max=input$ALTURA_MAX,
                                                                                      w_min=input$LARGURA_MIN, w_max=input$LARGURA_MAX, 
                                                                                      resposta=input$CORTAR), 
                                                     dataset_redim = REDIMENSIONAR(),
                                                     dataset_cortado = CORTAR(),
                                                     dataset_sem_edit= DATASET(),
                                                     
                                                     resposta_segment=input$SEGMENT_2,
                                                     
                                                     resposta_redm=input$REDIM, 
                                                     resposta_cortar=input$CORTAR,
                                                     segmentacao=SEGMENTACAO_2())
                    return(plot_im_final)
                }
            })
        
        
        output$PLOT_FINAL <-
            renderPlot({
                input$PERCENTAGEM
                isolate({
                    if (is.null(SEGMENTACAO_2())) {
                        NULL
                    } else {
                        PLOT_IMAGEM_FINAL()
                    }
                })
            })
        
        

        
        })

