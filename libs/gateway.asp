<!--
#include File="../libs/gatewayDTO.asp" --><!--
#include File="../libs/JSON_2.0.4.1.asp" --><!--
#include File="../libs/JSON_UTIL_0.1.1.asp" --><!--
#include File="../libs/JSON_PARSER.asp" --><%
Const IV = "0123456789abcdef"

Class Gateway

	Dim encrypter
	Dim siteKey

	private sub Class_Initialize()
		'64bit
		Set encrypter = Server.CreateObject ("Ryeol.StringEncrypter")
		'32bit
		'Set encrypter = Server.CreateObject ("Hyeongryeol.StringEncrypter")

		encrypter.InitialVector = IV
	end sub

	Private Sub Class_Terminate()
	End Sub

'	/**
'	 * 재생관련 룰 설정.
'	 *
'	 * *duration*
'	 * license 유지 시간 (단위 : 초).
'	 * 해당 값 세팅시 expire_date 값을 무시한다.
'	 * - Required
'	 * limit =true( false 일 경우 해당 값은 무시)
'	 *
'	 * *expire_date*
'	 * Playback Expiration Time, GMT Time 표기
'	 * yyyy-mm-ddThh:mm:ssZ
'	 * - Required
'	 * limit =true( false 일 경우 해당 값은 무시)
'	 * duration 항목을 제외해야한다.
'	 */
	Public Function CreatePlaybackPolicy(gatewayDTO)
		Dim j_playbackPolicy
		Set j_playbackPolicy = jsObject()

		j_playbackPolicy("persistent") = gatewayDTO.Persistent

		If gatewayDTO.Limit Then
			j_playbackPolicy("limit") = True
		If gatewayDTO.ExpireDate = "" Then
			j_playbackPolicy("duration") = gatewayDTO.Duration
		Else
			j_playbackPolicy("expire_date") = gatewayDTO.ExpireDate
		End If
		Else
			j_playbackPolicy("limit") = False
		End If

		CreatePlaybackPolicy = toJSON(j_playbackPolicy)
	End Function

' /**
'  * 보안 관련 룰 설정
'  */
	Public Function CreateSecurityPolicy(gatewayDTO)
		Dim j_securityPolicy, j_outputProtect
		Dim arr_outputProtect(0)
		Set j_securityPolicy = jsObject()
		Set j_outputProtect = jsObject()

		j_outputProtect("allow_external_display") = gatewayDTO.AllowExternalDisplay
		j_outputProtect("control_hdcp") = gatewayDTO.ControlHdcp

		Set arr_outputProtect(0) = j_outputProtect

		j_securityPolicy("output_protect") = arr_outputProtect
		j_securityPolicy("allow_mobile_abnormal_device") = gatewayDTO.AllowMoblieAbnormalDevice

		CreateSecurityPolicy = toJSON(j_securityPolicy)
	End Function

' /**
'  * 외부에서 패키징한 컨텐츠에 키 정보를 입력하여 라이센스 요청 시 사용
'	 */
	Public Function CreateExternalKey(gatewayDTO)
		Dim j_externalKey, j_mpegCenc, j_hlsAes, j_ncg
		Set j_externalKey = jsObject()
		Set j_mpegCenc = jsObject()
		Set j_hlsAes = jsObject()
		Set j_ncg = jsObject()


		If gatewayDTO.MpegCencKeyId <> "" Then
			j_mpegCenc("key_id") = gatewayDTO.MpegCencKeyId
		End If
		If gatewayDTO.MpegCencKey <> "" Then
			'response.write gatewayDTO.MpegCencKey
			j_mpegCenc("key") = gatewayDTO.MpegCencKey
		End If
		If gatewayDTO.MpegCencIv <> "" Then
			j_mpegCenc("iv") = gatewayDTO.MpegCencIv
		End If

		If gatewayDTO.HlsAesKey <> "" Then
			j_hlsAes("key") = gatewayDTO.HlsAesKey
		End If
		If gatewayDTO.HlsAesIv <> "" Then
			j_hlsAes("iv") = gatewayDTO.HlsAesIv
		End If

		If gatewayDTO.NcgCek <> "" Then
			j_ncg("cek") = gatewayDTO.NcgCek
		End If

		if j_mpegCenc.Collection.Count <> 0 Then
			Dim arr_mpegCenc(0)
			Set arr_mpegCenc(0) = j_mpegCenc
			j_externalKey("mpeg_cenc") = arr_mpegCenc
		End If
		if j_hlsAes.Collection.Count <> 0 Then
			Dim arr_hlsAes(0)
			Set arr_hlsAes(0) = j_hlsAes
			j_externalKey("hls_aes") = arr_hlsAes
		End If
		if j_ncg.Collection.Count <> 0 Then
			Dim arr_ncg(0)
			Set arr_ncg(0) = j_ncg
			j_externalKey("ncg") = arr_ncg
		End If

		CreateExternalKey = toJSON(j_externalKey)
	End Function

'	/**
'  * license rule 발급을 위한 json data를 생성하여 aes 암호화  하여 return 한다.
'  * @return string $return : aes encrypt json data
'  */
	Public Function CreateLicenseRule(gatewayDTO)
		Dim str_playbackPolicy, str_securityPolicy, str_externalKey
		Dim str_jsonResult

		str_playbackPolicy = CreatePlaybackPolicy(gatewayDTO)
		str_securityPolicy = CreateSecurityPolicy(gatewayDTO)

		str_externalKey = CreateExternalKey(gatewayDTO)

		str_jsonResult = "{"
		str_jsonResult = str_jsonResult & """error_code"":""" & gatewayDTO.ErrorCode & ""","
		str_jsonResult = str_jsonResult & """error_message"":""" & gatewayDTO.ErrorMessage & ""","
		str_jsonResult = str_jsonResult & """nonce"":""" & gatewayDTO.Nonce & ""","

		If gatewayDTO.ResponseUserId <> "" Then
			str_jsonResult = str_jsonResult & """response_user_id"":""" & gatewayDTO.ResponseUserId & ""","
		End If
			str_jsonResult = str_jsonResult & """playback_policy"":" & str_playbackPolicy & ","
			str_jsonResult = str_jsonResult & """security_policy"":" & str_securityPolicy
		If str_externalKey <> "{}" Then
			str_jsonResult = str_jsonResult & ",""external_key"":" & str_externalKey
		End If

		str_jsonResult = str_jsonResult & "}"
		gatewayDTO.LicenseRule = str_jsonResult
		'Response.write str_jsonResult
		CreateLicenseRule = encrypter.Encrypt(str_jsonResult)
	End Function

'	/**
'  * pack 정보를 json data로 생성하여  aes 암호화  하여 return 한다.
'  */
  Public Function CreatePackageInfo(gatewayDTO)
		Dim str_jsonResult
		str_jsonResult = "{"
		str_jsonResult = str_jsonResult & """error_code"":""" & gatewayDTO.ErrorCode & ""","
		str_jsonResult = str_jsonResult & """error_message"":""" & gatewayDTO.ErrorMessage & ""","
		str_jsonResult = str_jsonResult & """nonce"":""" & gatewayDTO.Nonce & ""","
		str_jsonResult = str_jsonResult & """cid"":""" & gatewayDTO.Cid & """"
		str_jsonResult = str_jsonResult & "}"

		'Response.write str_jsonResult
		gatewayDTO.PackInfo = str_jsonResult
		CreatePackageInfo = encrypter.Encrypt(str_jsonResult)
	End Function

'	/**
'  * aes 복호화 하여 나온 json string을 parsing 한다.
'  */
  Public Sub ParseRequestLicense(str_requestData, gatewayDTO)
		Dim str_data

		str_data = Replace (str_requestData, " ", "+")
			'Response.write str_data & "<br/>"
			str_data = encrypter.Decrypt(str_data)

			'Response.write str_data
			dim j_info : set j_info = JSON.parse(join(array(str_data)))
			on error resume next
			gatewayDTO.UserId = j_info.user_id
			gatewayDTO.Cid = j_info.cid
			gatewayDTO.Oid = j_info.oid
			gatewayDTO.Nonce = j_info.nonce
			gatewayDTO.DeviceId = j_info.device_id
			gatewayDTO.DeviceType = j_info.device_type
			gatewayDTO.DrmType = j_info.drm_type
			Err.Clear

		End Sub

'	/**
'  * aes 복호화 하여 나온 json string을 parsing 한다.
'  */
  Public Sub ParseRequestPackage(str_requestData, gatewayDTO)
		Dim str_data

		str_data = Replace (str_requestData, " ", "+")
		'Response.write str_data & "<br/>"
		str_data = encrypter.Decrypt(str_data)

		'Response.write str_data
		dim j_info : set j_info = JSON.parse(join(array(str_data)))
		gatewayDTO.FileName = j_info.file_name
		gatewayDTO.FilePath = j_info.file_path
		gatewayDTO.Nonce = j_info.nonce

	End Sub

'	/**
'  * pack 정보를 json data로 생성하여  aes 암호화  하여 return 한다.
'  */
	Public Function CreateErrorTemplete(gatewayDTO)
		Dim str_jsonResult
		str_jsonResult = "{"
		str_jsonResult = str_jsonResult & """error_code"":""" & gatewayDTO.ErrorCode & ""","
		str_jsonResult = str_jsonResult & """error_message"":""" & gatewayDTO.ErrorMessage & """"
		str_jsonResult = str_jsonResult & "}"

		'Response.write str_jsonResult
		gatewayDTO.ErrorInfo = str_jsonResult

		CreateErrorTemplete = encrypter.Encrypt(str_jsonResult)
	End Function


End Class


%>
