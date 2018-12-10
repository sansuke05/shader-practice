Shader "Custom/VF/HeartDraw" {
    Properties {
        _Color("Heart Color", Color) = (0, 0, 0, 1)
        //_Color("Back Color", Color) = (1, 1, 1, 0)
    }
    SubShader {
        Tags {
            "Queue" = "Transparent"
            "RenderType" = "Transparent"
        }

        Blend SrcAlpha OneMinusSrcAlpha

        Pass {
            CGPROGRAM

            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD;
            };

            struct v2f {
                float4 vertex : SV_POSITION;
                float2 uv : TEXCOORD;
            };

            fixed4 _Color;

            v2f vert(appdata v) {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            float createHeart(float2 st) {
                // 位置とか形の調整
                st = (st - float2(0.5, 0.38)) * float2(2.1, 2.8);

                return pow(st.x, 2) + pow(st.y - sqrt(abs(st.x)), 2);
            }

            fixed4 frag(v2f i) : SV_TARGET {
                float d = createHeart(i.uv);
                if(step(d, abs(sin(d * 8 - _Time.w * 2))) > 0.9) {
                    return _Color;
                } else {
                    return fixed4(0, 0, 0, 0);
                }
            }

            ENDCG
        }
    }
}