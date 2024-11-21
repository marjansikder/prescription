String getHtmlContentFull(String doctorInfo, String otherDetailsInfo, String patientInfo) {
  return """
 <!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Prescription Template</title>
    <style>
    
     body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }

        .rx-container {
            display: flex;
            justify-content: space-between;
            padding: 15px;
            background-color: #fdfdfd;
            height: auto; /* Adjust to content */
        }
        
        .footer-container {
            display: flex;
            justify-content: space-between;
            margin: 20px;
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 15px;
            background-color: #fdfdfd;
            height: auto; /* Adjust to content */
        }

        .column {
            flex: 1;
            padding: 10px;
            overflow: hidden; /* Prevent content overflow */
        }

        .middle-border {
            border-left: 1px solid #000;
            height: auto;
            margin: 0 15px;
        }

        .section {
            margin-bottom: 20px;
            word-wrap: break-word; /* Prevent long words from overflowing */
        }

        .section-title {
            font-weight: bold;
            margin-bottom: 5px;
            white-space: nowrap; /* Prevent the title from breaking into multiple lines */
        }

        .content {
            font-size: 14px;
            color: #555;
            margin: 5px 0; /* Space between lines */
        }

        .box-content {
            border: 1px solid #ddd;
            padding: 5px 10px;
            background-color: #fafafa;
            border-radius: 4px;
            margin-top: 5px;
        }

        .container {
            height: auto;
            padding: 10px;
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        
        .details-container {
            margin: 20px;
            padding: 10px;
        }

        .header {
            background-color: #c5b3f7;
            color: white;
            padding: 10px;
            margin: 10px;
            font-size: 24px;
            font-weight: bold;
        }

        .row {
            display: flex;
            justify-content: space-between;
            margin: 20px 0;
        }
        
        .divider {
            border-top: 1px solid black;
            margin: 10px;
        }

        .details-box {
            flex: 1;
            justify-content: First;
            margin: 0 10px;
            padding: 10px;
          
        }

        .box p {
            margin: 5px 0;
        }
        
        .footer-box {
            padding: 15px;
            
            background-color: #fdfdfd;
        }

        .middle-box {
            padding: 10px;
             margin: 0 0 0 10px;
            border-radius: 8px;
            text-align: left;
        }

        .footer {
            display: flex;
            justify-content: space-between;
            padding: 10px;
            border-top: 2px solid #ddd;
            margin-top: 20px;
            color: #333;
            background-color: #fafafa;
        }

        .footer .box {
            flex: 1;
            margin: 0 5px;
        }
        
        .footer-center {
           
            display: flex;
            justify-content:center;
            padding: 10px;
            border-top: 2px solid #ddd;
            margin-top: 20px 20px;
            color: #333;
            background-color: #fafafa;
        }
        
        .doctor-container {
           
            display: flex;
            justify-content:center;
            padding: 10px;
            border-top: 2px solid #ddd;
            margin-top: 20px 20px;
            color: #333;
            background-color: #fafafa;
        }

        .editable {
            font-weight: bold;
        }
    </style>
</head>
    <div class="container">
        <div class="header">Prescription</div>
        <div class="divider"></div>
        <div class="row">
            <!-- First Left Box -->
            <div class="details-box">
              <p>${doctorInfo}</p>
            </div>
            <div class="middle-border"></div>
            <!-- Second Right Box -->
            <div class="details-box">
                <p>${otherDetailsInfo}</p>
            </div>
        </div>
       
        <div class="divider"></div>
         <div class="middle-box">
            <p>${patientInfo}</p>
        </div>
         <div class="divider"></div>
            <div class="rx-container">
        <!-- Left Column -->
      
        <div class="column">
            <div class="section">
                <div class="section-title">Owners Complaint</div>
                <div class="content">Complaints</div>
                <div class="content">Remarks</div>
            </div>
            <div class="section">
                <div class="section-title">Clinical Findings</div>
                <div class="content">Complaints</div>
                <div class="content">Remarks</div>
            </div>
            <div class="section">
                <div class="section-title">Postmortem Findings</div>
                <div class="content">Complaints</div>
                <div class="content">Remarks</div>
            </div>
            <div class="section">
                <div class="section-title">Diagnosis</div>
                <div class="content">Complaints</div>
                <div class="content">Remarks</div>
            </div>
        </div>

        <!-- Middle Border -->
        <div class="middle-border"></div>

        <!-- Right Column -->
        <div class="column">
            <div class="section">
                <div class="section-title">Rx</div>
                <div class="content">Complaints</div>
                <div class="content">Remarks</div>
            </div>
            <div class="section">
                <div class="section-title">Advice</div>
                <div class="content">Complaints</div>
                <div class="content">Remarks</div>
            </div>
        </div>
        
    </div>
    <div class="footer-center">
            <p>ডাক্তারের পরামর্শ ব্যতিত কোন ঔষধ পরিবর্তন যোগ্য নয়</p>
        </div>
      
    </div>
</html>
  """;
}
