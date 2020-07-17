#!/bin/bash

lines=$(.github/files/jq-linux64 ' .results.TestResults.Issues.Issue[].Title' results.json | wc -l);
#echo $lines;
i=0;

touch veracode-sarif.json;

echo '
{
    "$schema" : "https://raw.githubusercontent.com/oasis-tcs/sarif-spec/master/Schemata/sarif-schema-2.1.0.json",
    "version" : "2.1.0",
    "runs" :
    [
    {
        "tool" : {
        "driver" : {
            "name" : "Veracode Pipeline Scanner"
        }
        },
        "results" : [ 
' >> veracode-sarif.json;

while [ $i != $lines ] ; 
do
    #echo $i;
    # strting the results array
    echo '{' >> veracode-sarif.json;
    # strting the results array

    # starting the message tag
    title=$(.github/files/jq-linux64 ' .results.TestResults.Issues.Issue['$i'].Title' results.json);
    issuetype=$(.github/files/jq-linux64 ' .results.TestResults.Issues.Issue['$i'].IssueType' results.json);
    #echo $title;
    echo '
        "message" : {
            "text" : '$title' - '$issuetype'
        },
    ' >> veracode-sarif.json;
    # ending the message tag

    #starting locations tag

    echo '
        "locations" : [ ' >> veracode-sarif.json;

    file=$(.github/files/jq-linux64 ' .results.TestResults.Issues.Issue['$i'].Files.SourceFile.File' results.json);
    line=$(.github/files/jq-linux64 ' .results.TestResults.Issues.Issue['$i'].Files.SourceFile.Line' results.json);
    function=$(.github/files/jq-linux64 ' .results.TestResults.Issues.Issue['$i'].Files.SourceFile.FunctionName' results.json);
    #echo $file;
    #echo $line:
    echo '
            {
                "physicalLocation" : {
                "artifactLocation" : {
                    "uri" : "File: '$file' - Line: '$line' - Function: '$function'"
                }
            },
    ' >> veracode-sarif.json

    echo '
        "region" : {
                "startLine" : '$line',
            }
    ' >> veracode-sarif.json

    echo '
        ]' >> veracode-sarif.json;

    #starting locations tag



    # ending the results array
    echo ' }' >> veracode-sarif.json;
    # ending the results array
    i=$[$i+1];
    #echo $i;
done

echo '
    ]
}
' >> veracode-sarif.json;
