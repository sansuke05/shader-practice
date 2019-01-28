Shader "Sansuke05/Rainbow" {
    Properties {
        _BaseColor("Base Color", Color) = (0, 0, 0, 1)
        _MainTex("Emission Mask Texture", 2D) = "white" {}
        _MainTex2("Texture", 2D) = "white" {}
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
            float2 uv_MainTex2;
        };

        fixed4 _BaseColor;
        sampler2D _MainTex;
        sampler2D _MainTex2;
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
            float4 mask = tex2D(_MainTex, IN.uv_MainTex);
            //clip(mask.r - 0.5); // do not draw if mask.r is less than 0.5

            float3 col = HSVToRGB( float3(mulTime, _Saturation, _Value) );
            o.Albedo = (mask.rgb > 0.5 ) ? mask * col : tex2D(_MainTex2, IN.uv_MainTex2);
            //o.Albedo = _BaseColor; //* mask;
            o.Emission = col * mask.rgb;
            o.Alpha = 1;
        }

        ENDCG
    }
    Fallback "Diffuse"
}