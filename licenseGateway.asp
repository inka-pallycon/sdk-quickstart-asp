<!--METADATA TYPE="typelib" NAME="ADODB Type Library"
      File="C:\Program Files\Common Files\System\ado\msado15.dll" --><%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"
%><%Response.ChaRset ="utf-8"
%><!--
#Include File= "config.asp" --><!--
#Include File= "libs/gateway.asp" --><%
Dim requestData

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
'requestData = "{""user_id"": ""test-user"", ""cid"":""DEMOtest-cid"", ""oid"": """", ""nonce"": ""3426u3050329384g"", ""device_id"": ""34905esdk-39ru303h-32jd90332"", ""device_type"": ""android"", ""drm_type"": ""NCG""}"
'requestData = obj_Gateway.encrypter.Encrypt(requestData)
'response.write requestData
obj_Gateway.ParseRequestLicense requestData, gwDto

'Response.write "userId : " & gwDto.UserId & "<br/>"
'Response.write "cid : " & gwDto.Cid & "<br/>"
'Response.write "oid : " & gwDto.Oid & "<br/>"
'Response.write "nonce : " & gwDto.Nonce & "<br/>"
'Response.write "drmType : " & gwDto.DrmType & "<br/>"

'/*-
'*
'* [업체 청책 반영]
'* 업체의 정책에 맞게 license rule을 생성하는 로직을 이곳에 구현합니다.
'*
'*
'* ** sample 소스는 무제한 라이센스로 세팅하게 되어 있습니다.
'*
'*
'* [Applying Content Usage Rights rule]
'*
'* Your Usage Rule generation logic can be applied here.
'* ** The sample source is setted unlimit license.
'*
'*
'*
'*/
'gwDto.Limit = True
'gwDto.Duration = 6000
'gwDto.ExpireDate = "2017-07-12T12:00:00Z"
'gwDto.AllowExternalDisplay = True
'gwDto.ResponseUserId = "testUser"
'gwDto.MpegCencKeyId = "9028465683937583"
'gwDto.MpegCencKey = "9028465683937583"
'gwDto.NcgCek = "9028465683937583"

Response.write obj_Gateway.CreateLicenseRule(gwDto)
'Response.write "license : " & gwDto.LicenseRule
Response.end





%>
