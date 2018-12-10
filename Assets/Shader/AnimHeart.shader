Shader "Custom/AnimHeart" {
    Properties {
        _HeartColor("Heart Color", Color) = (1, 1, 1, 1)
        [HDR] _EmissionColor("Emission Color", Color) = (1, 1, 1, 1)
        _MainTex("Main Texture", 2D) = "white" {}
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

        fixed4 _HeartColor;
        fixed4 _EmissionColor;
        sampler2D _MainTex;


        float createHeart(float2 st) {
            // 位置とか形の調整
            st = (st - float2(0.5, 0.38)) * float2(2.1, 2.8);

            return pow(st.x, 2) + pow(st.y - sqrt(abs(st.x)), 2);
        }

        void surf(Input IN, inout SurfaceOutputStandard o) {
            float d = createHeart(IN.uv_MainTex);
            if(step(d, abs(sin(d * 8 - _Time.w * 2))) > 0.9) {
                o.Albedo = _HeartColor.rgb;
                o.Alpha = _HeartColor.a;
                o.Emission = _EmissionColor;
            } else {
                o.Alpha = 0;
            }
        }

        ENDCG
    }
    Fallback "Diffuse"
}