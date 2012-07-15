Group Members:
  11500811g        QING Pei
  
Folder Structure:
  Presentation\
    
  RawData\
    *.sh ........................... Scripts cronned to get periodical results.
    crontab.txt .................... The cron tasks configured.
    parselog.py .................... Python code that processs log files and save .csv summaries.
    Plot.R ......................... R script that reads .csv files and plot pdf images.
    *.tar.gz ....................... Source tarballs of tools used. owamp and ntp.
    
    fig\
      *.pdf ........................ Figures plotted with the R script.
      *.jpg ........................ Converted images for insertion into Word document.
    
    log\
      *.txt ........................ Original outputs of routine tests.
    
    wireshark_capture\
      *.txt ........................ Original outputs of tests.
      capture* ..................... Wireshark captures of full-length tests.
      wireshark_simple ............. Wireshark capture of tests with few packets.
      gen_packets.sh ............... Script executed when capturing wireshark_simple.
  
  Report\
    