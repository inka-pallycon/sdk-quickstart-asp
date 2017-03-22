<!--METADATA TYPE="typelib" NAME="ADODB Type Library"
      File="C:\Program Files\Common Files\System\ado\msado15.dll" --><%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"
%><%Response.ChaRset ="utf-8"
%><!--
#Include File= "config.asp" --><!--
#Include File= "libs/gateway.asp" --><%
Dim requestData, str_cid

Set obj_Gateway = new Gateway
obj_Gateway.encrypter.Key = siteKey
Set gwDto = new GatewayDTO

If request.Form("data") = "" Then
'If request.Form("data") <> "" Then
  gwDto.ErrorCode = "2001"
  gwDto.ErrorMessage = "Request data is empty."
  Response.write obj_Gateway.CreateErrorTemplete(gwDto)
  'Response.write "decrypt error message : " & gwDto.ErrorInfo
  Response.end
End If
requestData = request.Form("data")

'sample
'requestData = "{""file_name"":""test-content.mp4"", ""file_path"":""c:\\lecture1\\test-content.mp4"", ""nonce"":""483476569283""}"
'response.write requestData
'requestData = obj_Gateway.encrypter.Encrypt(requestData)
'response.write requestData
obj_Gateway.ParseRequestPackage requestData, gwDto

'Response.write "fileName : " & gwDto.FileName & "<br/>"
'Response.write "filePath : " & gwDto.FilePath & "<br/>"

'/*-
'*
'* [업체 청책 반영]
'*
'* 업체의 정책에 맞게 Content ID를 생성하는 로직을 이곳에 구현합니다.
'* Content ID를 생성하는데 활용할 값은 다음과 같습니다.
'*
'* - gwDto.FileName
'* - gwDto.FilePath
'*
'*
'*	퀵스타트 샘플은 파일명의 확장자를 제거한 파일명을 cid로 세팅하게 되어있습니다.
'*	확장자를 제거한 파일명이 28자리를 넘어갈 경우 에러가 발생되게 됩니다.
'*
'*
'* [Applying CID rule]
'*
'* Your CID generation logic can be applied here.
'* The below parameters can be used for the logic.
'*
'* - gwDto.FileName
'* - gwDto.FilePath
'*
'*/
str_cid = Split(gwDto.FileName, ".")(0)
gwDto.Cid = str_cid

Response.write obj_Gateway.CreatePackageInfo(gwDto)
'Response.write "PackInfo : " & gwDto.PackInfo
Response.end





%>
