Shader "Custom/Trans" {
    Properties {
        _BaseColor("Base Color", Color) = (1,1,1,1)
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

        float4 _BaseColor;

        void surf(Input IN, inout SurfaceOutputStandard o) {
            o.Albedo = _BaseColor.rgb;
            o.Alpha = 0.6;
        }

        ENDCG
    }
    Fallback "Diffuse"
}