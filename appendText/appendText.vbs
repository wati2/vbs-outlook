' Text남기는 VBScript
' VBScript Encoding EUC-KR
' -------------------
'
' 다른 VBS에서 호출하는 방법
' WshShell 오브젝트 만들고
' WshShell.Run 으로 원하는 VBS 호출
' 파라미터는 " " 스페이스 1칸 으로 구분하여 전달 가능
' 아래는 예시 
'
' Set WshShell = WScript.CreateObject("WScript.Shell")
' WshShell.Run(호출할vbs경로 + " " + Text남길경로 + " " + Text남길내용 )
'
' 다만 Automation Anywhere 에서 RunScript 통해 호출한 VBScript에서 다시 다른 VBScript 파일을 호출하는 경우는 수행되지 않음 ( Error )
' 하지만 Command prompt 에서 수행하면 정상적으로 다른 파일도 호출 됨을 확인함..!
'
' Automation Anywhere의 Run Script 커맨드를 통해 사용하고싶으면
' 하나의 VBScript 파일 안에 Sub 이나 Function 형태로 만들어서
' 사용하면 좋은 형태가 될 듯 


' Example
'
' 파라미터 두개다 있는 경우
if wscript.arguments.count = 2 then 
    pathLogFileName = WScript.Arguments(0)
    appendText = WScript.Arguments(1)

' 파라미터 0개인경우 바탕화면에 테스트 Text 남김
elseif wscript.arguments.count = 0 then
    msgBox "appendLog.vbs > Test > 파라미터 0개인 경우 바탕화면에 Test Text 남김"
    Set WshShell = CreateObject("wscript.Shell") 
    pathUserProfile = WshShell.ExpandEnvironmentStrings("%UserProfile%")
    pathLogFileName = pathUserProfile & "\Desktop\test.log"
    appendText = "Test"
    
else 
    msgBox "파라미터 개수 2개필요 1.Text파일 path, 2.Text남길 내용"    
    WScript.Quit
    
end if

' OpenTextFile 8이면 Append 옵션임, https://docs.microsoft.com/en-us/office/vba/language/reference/user-interface-help/opentextfile-method
Set objFileToWrite = CreateObject("Scripting.FileSystemObject").OpenTextFile(pathLogFileName,8,true)

writeData = "(" & Now & ") " & appendText 
objFileToWrite.WriteLine(writeData)
objFileToWrite.Close


'Clear the memory
Set objFileToWrite = Nothing




