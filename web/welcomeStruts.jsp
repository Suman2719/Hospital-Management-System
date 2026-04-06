<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>

<html:html lang="true">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><bean:message key="welcome.title"/></title>
        <html:base/>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
                background-color: #f9f9f9;
                color: #333;
            }
            .container {
                max-width: 700px;
                margin: 80px auto;
                background: #fff;
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0 4px 12px rgba(0,0,0,0.1);
                text-align: center;
            }
            h3 {
                color: #007bff;
                margin-bottom: 15px;
            }
            p {
                font-size: 16px;
                line-height: 1.6;
            }
            .error {
                color: #d9534f;
                font-weight: bold;
                margin-bottom: 15px;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <logic:notPresent name="org.apache.struts.action.MESSAGE" scope="application">
                <div class="error">
                    ERROR: Application resources not loaded — check servlet container logs for error messages.
                </div>
            </logic:notPresent>

            <h3><bean:message key="welcome.heading"/></h3>
            <p><bean:message key="welcome.message"/></p>
        </div>
    </body>
</html:html>
