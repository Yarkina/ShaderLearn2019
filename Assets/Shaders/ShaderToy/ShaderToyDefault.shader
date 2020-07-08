Shader "Custom/ShaderToy/ShaderToyDefault"
{
    Properties
    {
    }
    SubShader
    {

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            fixed3 frag (v2f i) : SV_Target
            {
                fixed3 col = 0.5+0.5*cos(_Time + i.uv.xyx + fixed3(0,2,4));
				//col = fixed3(0, 0, col.z);
                return col;
            }
            ENDCG
        }
    }
}