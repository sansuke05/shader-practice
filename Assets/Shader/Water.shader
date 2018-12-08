Shader "Custom/Water" {
    Properties {
        _MainTex("Water Texture", 2D) = "white" {}
        _XSpeed("X Speed", Range(0, 1)) = 0.1
        _YSpeed("Y Speed", Range(0, 1)) = 0.2
        _WaterAlpha("Water Alpha", Range(0, 1)) = 0.7
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
        fixed _XSpeed;
        fixed _YSpeed;
        fixed _WaterAlpha;

        void surf(Input IN, inout SurfaceOutputStandard o) {
            // UVスクロール
            fixed2 uv = IN.uv_MainTex;
            // 移動距離 = スクロール速度 x 時間(フレーム情報)
            uv.x += _XSpeed * _Time;
            uv.y += _YSpeed * _Time;
            o.Albedo = tex2D(_MainTex, uv);
            o.Alpha = _WaterAlpha;
        }

        ENDCG
    }
    Fallback "Diffuse"
}