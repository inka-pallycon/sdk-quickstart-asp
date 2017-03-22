<%
Class GatewayDTO
  private m_errorCode
  private m_limit
  private m_persistent
  private m_duration
  private m_hardwareDrm
  private m_allowMoblieAbnormalDevice, m_allowExternalDisplay, m_controlHdcp
  private m_mpegCencKeyId, m_mpegCencKey, m_mpegCencIv
  private m_hlsAesKey, m_hlsAesIv
  private m_ncgCek
  private m_expireDate, m_errorMessage, m_nonce
  private m_cid, m_deviceId, m_deviceType, m_oid, m_userId, m_responseUserId, m_drmType
  private m_fileName, m_filePath
  private m_licenseRule, m_packInfo, m_errorInfo

  Public Property Get ErrorCode()
    If m_errorCode = "" Then
      ErrorCode = "0000"
    Else
      ErrorCode = m_errorCode
    End If
  End Property

  Public Property Let ErrorCode(s_errorCode)
    m_errorCode = s_errorCode
  End Property

  Public Property Get Limit()
    If m_limit = "" Then
      Limit = False
    Else
      Limit = m_limit
    End If
  End Property

  Public Property Let Limit(b_limit)
    m_limit = b_limit
  End Property

  Public Property Get Persistent()
    If m_persistent = "" Then
      Persistent = False
    Else
      Persistent = m_persistent
    End If
  End Property

  Public Property Let Persistent(b_persistent)
    m_persistent = b_persistent
  End Property

  Public Property Get Duration()
  If m_duration = "" Then
    Duration = 0
  Else
    Duration = m_duration
  End If
  End Property

  Public Property Let Duration(l_duration)
    m_duration = l_duration
  End Property

  Public Property Get HardwareDrm()
    If m_hardwareDrm = "" Then
      HardwareDrm = False
    Else
      HardwareDrm = m_hardwareDrm
    End If
  End Property

  Public Property Let HardwareDrm(b_hardwareDrm)
    m_hardwareDrm = b_hardwareDrm
  End Property



  Public Property Get AllowMoblieAbnormalDevice()

    If m_allowMoblieAbnormalDevice = "" Then
      AllowMoblieAbnormalDevice = False
    Else
      AllowMoblieAbnormalDevice = m_allowMoblieAbnormalDevice
    End If
  End Property

  Public Property Let AllowMoblieAbnormalDevice(b_allowMoblieAbnormalDevice)
    m_allowMoblieAbnormalDevice = b_allowMoblieAbnormalDevice
  End Property

  Public Property Get AllowExternalDisplay()
    If m_allowExternalDisplay = "" Then
      AllowExternalDisplay = False
    Else
      AllowExternalDisplay = m_allowExternalDisplay
    End If
  End Property

  Public Property Let AllowExternalDisplay(b_allowExternalDisplay)
    m_allowExternalDisplay = b_allowExternalDisplay
  End Property

  Public Property Get ControlHdcp()
  If m_controlHdcp = "" Then
    ControlHdcp = 0
  Else
    ControlHdcp = m_controlHdcp
  End If
  End Property

  Public Property Let ControlHdcp(l_controlHdcp)
    m_controlHdcp = l_controlHdcp
  End Property

  Public Property Get MpegCencKeyId()
    MpegCencKeyId = m_mpegCencKeyId
  End Property

  Public Property Let MpegCencKeyId(s_mpegCencKeyId)
    m_mpegCencKeyId = s_mpegCencKeyId
  End Property

  Public Property Get MpegCencKey()
    MpegCencKey = m_mpegCencKey
  End Property

  Public Property Let MpegCencKey(s_mpegCencKey)
    m_mpegCencKey = s_mpegCencKey
  End Property

  Public Property Get MpegCencIv()
    MpegCencIv = m_mpegCencIv
  End Property

  Public Property Let MpegCencIv(s_mpegCencIv)
    m_mpegCencIv = s_mpegCencIv
  End Property

  Public Property Get HlsAesKey()
    HlsAesKey = m_hlsAesKey
  End Property

  Public Property Let HlsAesKey(s_hlsAesKey)
    m_hlsAesKey = s_hlsAesKey
  End Property

  Public Property Get HlsAesIv()
    HlsAesIv = m_hlsAesIv
  End Property

  Public Property Let HlsAesIv(s_hlsAesIv)
    m_hlsAesIv = s_hlsAesIv
  End Property

  Public Property Get NcgCek()
    NcgCek = m_ncgCek
  End Property

  Public Property Let NcgCek(s_ncgCek)
    m_ncgCek = s_ncgCek
  End Property

  Public Property Get ExpireDate()
    ExpireDate = m_expireDate
  End Property

  Public Property Let ExpireDate(s_expireDate)
    m_expireDate = s_expireDate
  End Property

  Public Property Get ErrorMessage()
    If m_errorMessage = "" Then
      ErrorMessage = "success"
    Else
      ErrorMessage = m_errorMessage
    End If
  End Property

  Public Property Let ErrorMessage(s_errorMessage)
    m_errorMessage = s_errorMessage
  End Property

  Public Property Get Nonce()
    Nonce = m_nonce
  End Property

  Public Property Let Nonce(s_nonce)
    m_nonce = s_nonce
  End Property

  Public Property Get Cid()
    Cid = m_cid
  End Property

  Public Property Let Cid(s_cid)
    m_cid = s_cid
  End Property

  Public Property Get DeviceId()
    DeviceId = m_deviceId
  End Property

  Public Property Let DeviceId(s_deviceId)
    m_deviceId = s_dviceId
  End Property

  Public Property Get DeviceType()
    DeviceType = m_deviceType
  End Property

  Public Property Let DeviceType(s_deviceType)
    m_deviceType = s_deviceType
  End Property

  Public Property Get Oid()
    Oid = m_oid
  End Property

  Public Property Let Oid(s_oid)
    m_oid = s_oid
  End Property

  Public Property Get UserId()
    UserId = m_userId
  End Property

  Public Property Let UserId(s_userId)
    m_userId = s_userId
  End Property

  Public Property Get ResponseUserId()
    ResponseUserId = m_responseUserId
  End Property

  Public Property Let ResponseUserId(s_responseUserId)
    m_responseUserId = s_responseUserId
  End Property

  Public Property Get DrmType()
    DrmType = m_drmType
  End Property

  Public Property Let DrmType(s_drmType)
    m_drmType = s_drmType
  End Property

  Public Property Get FileName()
    FileName = m_fileName
  End Property

  Public Property Let FileName(s_fileName)
    m_fileName = s_fileName
  End Property

  Public Property Get FilePath()
    FilePath = m_filePath
  End Property

  Public Property Let FilePath(s_filePath)
    m_filePath = s_filePath
  End Property

  Public Property Get LicenseRule()
    LicenseRule = m_licenseRule
  End Property

  Public Property Let LicenseRule(s_licenseRule)
    m_licenseRule = s_licenseRule
  End Property

  Public Property Get PackInfo()
    PackInfo = m_packInfo
  End Property

  Public Property Let PackInfo(s_packInfo)
    m_packInfo = s_packInfo
  End Property

  Public Property Get ErrorInfo()
    ErrorInfo = m_errorInfo
  End Property

  Public Property Let ErrorInfo(s_errorInfo)
    m_errorInfo = s_errorInfo
  End Property
End Class
%>
