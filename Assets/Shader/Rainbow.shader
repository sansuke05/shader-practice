Shader "Sansuke05/Rainbow" {
    Properties {
        _MainTex("Base Texture", 2D) = "white" {}
        _EmissionMaskTex("Emission Mask Texture", 2D) = "white" {}
        _MaskLevel("Emission Mask level", Range(0, 1)) = 0.5
        _OverTex("Metallic and Smoothness Texture", 2D) = "white" {}
        _Metallic ("Metallic", Range(0,1)) = 0.0
        _Glossiness ("Smoothness", Range(0,1)) = 0.5
        _Speed("Speed", Range( 0 , 3)) = 0.2
        _Value("Value", Range( 0 , 1)) = 0.5
		_Saturation("Saturation", Range( 0 , 1)) = 0.5
    }
    SubShader {
        Tags {
            "RenderType" = "Opaque"
        }
        LOD 200

        CGPROGRAM

        #pragma surface surf Standard fullforwardshadows
        #pragma target 3.0

        struct Input {
            float2 uv_MainTex;
            float2 uv_EmissionMaskTex;
            float2 uv_OverTex;
        };

        sampler2D _MainTex;
        sampler2D _EmissionMaskTex;
        sampler2D _OverTex;
        half _MaskLevel;
        half _Metallic;
        half _Glossiness;
        float _Speed;
        float _Saturation;
        float _Value;

        float3 HSVToRGB( float3 c ) {
			float4 K = float4( 1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0 );
			float3 p = abs( frac( c.xxx + K.xyz ) * 6.0 - K.www );
			return c.z * lerp( K.xxx, saturate( p - K.xxx ), c.y );
		}

        void surf(Input IN, inout SurfaceOutputStandard o) {
            float mulTime = _Time.y * _Speed;
            float4 mask = tex2D(_EmissionMaskTex, IN.uv_EmissionMaskTex);

            float3 col = HSVToRGB( float3(mulTime, _Saturation, _Value) );
            o.Albedo = (mask.rgb > _MaskLevel ) ? mask * col : tex2D(_MainTex, IN.uv_MainTex);
            o.Emission = col * mask.rgb;

            o.Metallic = tex2D(_OverTex, IN.uv_OverTex).a * _Metallic;
            o.Smoothness = tex2D(_OverTex, IN.uv_OverTex).a * _Glossiness;
            o.Alpha = 1;
        }

        ENDCG
    }
    Fallback "Diffuse"
}