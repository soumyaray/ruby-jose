require 'test_helper'

class JOSETest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::JOSE::VERSION
  end

  # JSON Web Encryption (JWE)
  # A.1.  Example JWE using RSAES-OAEP and AES GCM
  # https://tools.ietf.org/html/rfc7516#appendix-A.1
  def test_jwe_a_1
    # A.1
    a_1_txt = [84,104,101,32,116,114,117,101,32,115,105,103,110,32,111,102,32,105,110,116,101,108,108,105,103,101,110,99,101,32,105,115,32,110,111,116,32,107,110,111,119,108,101,100,103,101,32,98,117,116,32,105,109,97,103,105,110,97,116,105,111,110,46].pack('C*')
    # A.1.1
    a_1_1_jwe_json = "{\"alg\":\"RSA-OAEP\",\"enc\":\"A256GCM\"}"
    a_1_1_jwe_json_b64 = "eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZHQ00ifQ"
    a_1_1_jwe_map = JOSE.decode(a_1_1_jwe_json)
    a_1_1_jwe = JOSE::JWE.from_binary(a_1_1_jwe_json)
    assert_equal a_1_1_jwe_map, a_1_1_jwe.to_map
    assert_equal a_1_1_jwe_json_b64, JOSE.urlsafe_encode64(a_1_1_jwe.to_binary)
    # A.1.2
    a_1_2_cek = [177,161,244,128,84,143,225,115,63,180,3,255,107,154,212,246,138,7,110,91,112,46,34,105,47,130,203,46,122,234,64,252].pack('C*')
    # A.1.3
    a_1_3_jwk_json = "{\"kty\":\"RSA\",\"n\":\"oahUIoWw0K0usKNuOR6H4wkf4oBUXHTxRvgb48E-BVvxkeDNjbC4he8rUWcJoZmds2h7M70imEVhRU5djINXtqllXI4DFqcI1DgjT9LewND8MW2Krf3Spsk_ZkoFnilakGygTwpZ3uesH-PFABNIUYpOiN15dsQRkgr0vEhxN92i2asbOenSZeyaxziK72UwxrrKoExv6kc5twXTq4h-QChLOln0_mtUZwfsRaMStPs6mS6XrgxnxbWhojf663tuEQueGC-FCMfra36C9knDFGzKsNa7LZK2djYgyD3JR_MB_4NUJW_TqOQtwHYbxevoJArm-L5StowjzGy-_bq6Gw\",\"e\":\"AQAB\",\"d\":\"kLdtIj6GbDks_ApCSTYQtelcNttlKiOyPzMrXHeI-yk1F7-kpDxY4-WY5NWV5KntaEeXS1j82E375xxhWMHXyvjYecPT9fpwR_M9gV8n9Hrh2anTpTD93Dt62ypW3yDsJzBnTnrYu1iwWRgBKrEYY46qAZIrA2xAwnm2X7uGR1hghkqDp0Vqj3kbSCz1XyfCs6_LehBwtxHIyh8Ripy40p24moOAbgxVw3rxT_vlt3UVe4WO3JkJOzlpUf-KTVI2Ptgm-dARxTEtE-id-4OJr0h-K-VFs3VSndVTIznSxfyrj8ILL6MG_Uv8YAu7VILSB3lOW085-4qE3DzgrTjgyQ\",\"p\":\"1r52Xk46c-LsfB5P442p7atdPUrxQSy4mti_tZI3Mgf2EuFVbUoDBvaRQ-SWxkbkmoEzL7JXroSBjSrK3YIQgYdMgyAEPTPjXv_hI2_1eTSPVZfzL0lffNn03IXqWF5MDFuoUYE0hzb2vhrlN_rKrbfDIwUbTrjjgieRbwC6Cl0\",\"q\":\"wLb35x7hmQWZsWJmB_vle87ihgZ19S8lBEROLIsZG4ayZVe9Hi9gDVCOBmUDdaDYVTSNx_8Fyw1YYa9XGrGnDew00J28cRUoeBB_jKI1oma0Orv1T9aXIWxKwd4gvxFImOWr3QRL9KEBRzk2RatUBnmDZJTIAfwTs0g68UZHvtc\",\"dp\":\"ZK-YwE7diUh0qR1tR7w8WHtolDx3MZ_OTowiFvgfeQ3SiresXjm9gZ5KLhMXvo-uz-KUJWDxS5pFQ_M0evdo1dKiRTjVw_x4NyqyXPM5nULPkcpU827rnpZzAJKpdhWAgqrXGKAECQH0Xt4taznjnd_zVpAmZZq60WPMBMfKcuE\",\"dq\":\"Dq0gfgJ1DdFGXiLvQEZnuKEN0UUmsJBxkjydc3j4ZYdBiMRAy86x0vHCjywcMlYYg4yoC4YZa9hNVcsjqA3FeiL19rk8g6Qn29Tt0cj8qqyFpz9vNDBUfCAiJVeESOjJDZPYHdHY8v1b-o-Z2X5tvLx-TCekf7oxyeKDUqKWjis\",\"qi\":\"VIMpMYbPf47dT1w_zDUXfPimsSegnMOA1zTaX7aGk_8urY6R8-ZW1FxU7AlWAyLWybqq6t16VFd7hQd0y6flUK4SlOydB61gwanOsXGOAOv82cHq0E3eL4HrtZkUuKvnPrMnsUUFlfUdybVzxyjz9JF_XyaY14ardLSjf4L_FNY\"}"
    a_1_3_cek_encrypted = [56,163,154,192,58,53,222,4,105,218,136,218,29,94,203,22,150,92,129,94,211,232,53,89,41,60,138,56,196,216,82,98,168,76,37,73,70,7,36,8,191,100,136,196,244,220,145,158,138,155,4,117,141,230,199,247,173,45,182,214,74,177,107,211,153,11,205,196,171,226,162,128,171,182,13,237,239,99,193,4,91,219,121,223,107,167,61,119,228,173,156,137,134,200,80,219,74,253,56,185,91,177,34,158,89,154,205,96,55,18,138,43,96,218,215,128,124,75,138,243,85,25,109,117,140,26,155,249,67,167,149,231,100,6,41,65,214,251,232,87,72,40,182,149,154,168,31,193,126,215,89,28,111,219,125,182,139,235,195,197,23,234,55,58,63,180,68,202,206,149,75,205,248,176,67,39,178,60,98,193,32,238,122,96,158,222,57,183,111,210,55,188,215,206,180,166,150,166,106,250,55,229,72,40,69,214,216,104,23,40,135,212,28,127,41,80,175,174,168,115,171,197,89,116,92,103,246,83,216,182,176,84,37,147,35,45,219,172,99,226,233,73,37,124,42,72,49,242,35,127,184,134,117,114,135,206].pack('C*')
    a_1_3_cek_encrypted_b64 = "OKOawDo13gRp2ojaHV7LFpZcgV7T6DVZKTyKOMTYUmKoTCVJRgckCL9kiMT03JGeipsEdY3mx_etLbbWSrFr05kLzcSr4qKAq7YN7e9jwQRb23nfa6c9d-StnImGyFDbSv04uVuxIp5Zms1gNxKKK2Da14B8S4rzVRltdYwam_lDp5XnZAYpQdb76FdIKLaVmqgfwX7XWRxv2322i-vDxRfqNzo_tETKzpVLzfiwQyeyPGLBIO56YJ7eObdv0je81860ppamavo35UgoRdbYaBcoh9QcfylQr66oc6vFWXRcZ_ZT2LawVCWTIy3brGPi6UklfCpIMfIjf7iGdXKHzg"
    a_1_3_jwk_map = JOSE.decode(a_1_3_jwk_json)
    a_1_3_jwk = JOSE::JWK.from_binary(a_1_3_jwk_json)
    assert_equal a_1_3_jwk_map, a_1_3_jwk.to_map
    assert_equal a_1_3_cek_encrypted_b64, JOSE.urlsafe_encode64(a_1_3_cek_encrypted)
    # A.1.4
    a_1_4_iv = [227,197,117,252,2,219,233,68,180,225,77,219].pack('C*')
    a_1_4_iv_b64 = "48V1_ALb6US04U3b"
    assert_equal a_1_4_iv_b64, JOSE.urlsafe_encode64(a_1_4_iv)
    # A.1.5
    a_1_5_aad = [101,121,74,104,98,71,99,105,79,105,74,83,85,48,69,116,84,48,70,70,85,67,73,115,73,109,86,117,89,121,73,54,73,107,69,121,78,84,90,72,81,48,48,105,102,81].pack('C*')
    assert_equal a_1_5_aad, a_1_1_jwe_json_b64
    # A.1.6
    a_1_6_txt_cipher = [229,236,166,241,53,191,115,196,174,43,73,109,39,122,233,96,140,206,120,52,51,237,48,11,190,219,186,80,111,104,50,142,47,167,59,61,181,127,196,21,40,82,242,32,123,143,168,226,73,216,176,144,138,247,106,60,16,205,160,109,64,63,192].pack('C*')
    a_1_6_txt_tag = [92,80,104,49,133,25,161,215,173,101,219,211,136,91,210,145].pack('C*')
    a_1_6_txt_cipher_b64 = "5eym8TW_c8SuK0ltJ3rpYIzOeDQz7TALvtu6UG9oMo4vpzs9tX_EFShS8iB7j6jiSdiwkIr3ajwQzaBtQD_A"
    a_1_6_txt_tag_b64 = "XFBoMYUZodetZdvTiFvSkQ"
    assert_equal a_1_6_txt_cipher_b64, JOSE.urlsafe_encode64(a_1_6_txt_cipher)
    assert_equal a_1_6_txt_tag_b64, JOSE.urlsafe_encode64(a_1_6_txt_tag)
    # A.1.7
    a_1_7_jwe_compact = "eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkEyNTZHQ00ifQ.OKOawDo13gRp2ojaHV7LFpZcgV7T6DVZKTyKOMTYUmKoTCVJRgckCL9kiMT03JGeipsEdY3mx_etLbbWSrFr05kLzcSr4qKAq7YN7e9jwQRb23nfa6c9d-StnImGyFDbSv04uVuxIp5Zms1gNxKKK2Da14B8S4rzVRltdYwam_lDp5XnZAYpQdb76FdIKLaVmqgfwX7XWRxv2322i-vDxRfqNzo_tETKzpVLzfiwQyeyPGLBIO56YJ7eObdv0je81860ppamavo35UgoRdbYaBcoh9QcfylQr66oc6vFWXRcZ_ZT2LawVCWTIy3brGPi6UklfCpIMfIjf7iGdXKHzg.48V1_ALb6US04U3b.5eym8TW_c8SuK0ltJ3rpYIzOeDQz7TALvtu6UG9oMo4vpzs9tX_EFShS8iB7j6jiSdiwkIr3ajwQzaBtQD_A.XFBoMYUZodetZdvTiFvSkQ"
    a_1_7_txt, a_1_7_jwe = JOSE::JWE.block_decrypt(a_1_3_jwk, a_1_7_jwe_compact)
    assert_equal a_1_txt, a_1_7_txt
    assert_equal a_1_1_jwe, a_1_7_jwe
    # Roundtrip test
    a_1_7_map = JOSE::JWE.block_encrypt(a_1_3_jwk, a_1_txt, a_1_1_jwe, a_1_2_cek, a_1_4_iv)
    a_1_7_txt, a_1_7_jwe = JOSE::JWE.block_decrypt(a_1_3_jwk, a_1_7_map)
    assert_equal a_1_txt, a_1_7_txt
    assert_equal a_1_1_jwe, a_1_7_jwe
  end

  # JSON Web Encryption (JWE)
  # A.3.  Example JWE Using AES Key Wrap and AES_128_CBC_HMAC_SHA_256
  # https://tools.ietf.org/html/rfc7516#appendix-A.3
  def test_jwe_a_3
    # A.3
    a_3_txt = [76,105,118,101,32,108,111,110,103,32,97,110,100,32,112,114,111,115,112,101,114,46].pack('C*')
    # A.3.1
    a_3_1_jwe_json = "{\"alg\":\"A128KW\",\"enc\":\"A128CBC-HS256\"}"
    a_3_1_jwe_json_b64 = "eyJhbGciOiJBMTI4S1ciLCJlbmMiOiJBMTI4Q0JDLUhTMjU2In0"
    a_3_1_jwe_map = JOSE.decode(a_3_1_jwe_json)
    a_3_1_jwe = JOSE::JWE.from_binary(a_3_1_jwe_json)
    assert_equal a_3_1_jwe_map, a_3_1_jwe.to_map
    assert_equal a_3_1_jwe_json_b64, JOSE.urlsafe_encode64(a_3_1_jwe.to_binary)
    # A.3.2
    a_3_2_cek = [4,211,31,197,84,157,252,254,11,100,157,250,63,170,106,206,107,124,212,45,111,107,9,219,200,177,0,240,143,156,44,207].pack('C*')
    # A.3.3
    a_3_3_jwk_json = "{\"kty\":\"oct\",\"k\":\"GawgguFyGrWKav7AX4VKUg\"}"
    a_3_3_cek_encrypted = [232,160,123,211,183,76,245,132,200,128,123,75,190,216,22,67,201,138,193,186,9,91,122,31,246,90,28,139,57,3,76,124,193,11,98,37,173,61,104,57].pack('C*')
    a_3_3_cek_encrypted_b64 = "6KB707dM9YTIgHtLvtgWQ8mKwboJW3of9locizkDTHzBC2IlrT1oOQ"
    a_3_3_jwk_map = JOSE.decode(a_3_3_jwk_json)
    a_3_3_jwk = JOSE::JWK.from_binary(a_3_3_jwk_json)
    assert_equal a_3_3_jwk_map, a_3_3_jwk.to_map
    assert_equal a_3_3_cek_encrypted_b64, JOSE.urlsafe_encode64(a_3_3_cek_encrypted)
    # A.3.4
    a_3_4_iv = [3,22,60,12,43,67,104,105,108,108,105,99,111,116,104,101].pack('C*')
    a_3_4_iv_b64 = "AxY8DCtDaGlsbGljb3RoZQ"
    assert_equal a_3_4_iv_b64, JOSE.urlsafe_encode64(a_3_4_iv)
    # A.3.5
    a_3_5_aad = [101,121,74,104,98,71,99,105,79,105,74,66,77,84,73,52,83,49,99,105,76,67,74,108,98,109,77,105,79,105,74,66,77,84,73,52,81,48,74,68,76,85,104,84,77,106,85,50,73,110,48].pack('C*')
    assert_equal a_3_5_aad, a_3_1_jwe_json_b64
    # A.3.6
    a_3_6_txt_cipher = [40,57,83,181,119,33,133,148,198,185,243,24,152,230,6,75,129,223,127,19,210,82,183,230,168,33,215,104,143,112,56,102].pack('C*')
    a_3_6_txt_tag = [83,73,191,98,104,205,211,128,201,189,199,133,32,38,194,85].pack('C*')
    a_3_6_txt_cipher_b64 = "KDlTtXchhZTGufMYmOYGS4HffxPSUrfmqCHXaI9wOGY"
    a_3_6_txt_tag_b64 = "U0m_YmjN04DJvceFICbCVQ"
    assert_equal a_3_6_txt_cipher_b64, JOSE.urlsafe_encode64(a_3_6_txt_cipher)
    assert_equal a_3_6_txt_tag_b64, JOSE.urlsafe_encode64(a_3_6_txt_tag)
    # A.3.7
    a_3_7_jwe_compact = "eyJhbGciOiJBMTI4S1ciLCJlbmMiOiJBMTI4Q0JDLUhTMjU2In0.6KB707dM9YTIgHtLvtgWQ8mKwboJW3of9locizkDTHzBC2IlrT1oOQ.AxY8DCtDaGlsbGljb3RoZQ.KDlTtXchhZTGufMYmOYGS4HffxPSUrfmqCHXaI9wOGY.U0m_YmjN04DJvceFICbCVQ"
    a_3_7_txt, a_3_7_jwe = JOSE::JWE.block_decrypt(a_3_3_jwk, a_3_7_jwe_compact)
    assert_equal a_3_txt, a_3_7_txt
    assert_equal a_3_1_jwe, a_3_7_jwe
    # Roundtrip test
    a_3_7_map = JOSE::JWE.block_encrypt(a_3_3_jwk, a_3_txt, a_3_1_jwe, a_3_2_cek, a_3_4_iv)
    a_3_7_txt, a_3_7_jwe = JOSE::JWE.block_decrypt(a_3_3_jwk, a_3_7_map)
    assert_equal a_3_txt, a_3_7_txt
    assert_equal a_3_1_jwe, a_3_7_jwe
  end
end
