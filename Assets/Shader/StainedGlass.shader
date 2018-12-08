Shader "Custom/StainedGlass" {
    Properties {
        _MainTex("Texture", 2D) = "white" {}
    }
    SubShader {
        Tags {
            "RenderType" = "Transparent"
        }
        LOD 200

        CGPROGRAM

        #pragma surface surf Standard alpha:fade
        #pragma target 3.0

        struct Input {
            float2 uv_MainTex;
        };

        sampler2D _MainTex;

        void surf(Input IN, inout SurfaceOutputStandard o) {
            fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
            // グレースケールPixcelを生成
            fixed gray = c.r * 0.3 + c.g * 0.6 + c.b * 0.1;
            o.Albedo = c.rgb;
            o.Alpha = gray > 0.2 ? 0.7 : 1;
        }

        ENDCG
    }
    Fallback "Diffuse"
}