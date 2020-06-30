Shader "Unlit/ChessBoard"
{
    Properties
    {
		_Color("Color",color) = (1,1,1,1)
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

			fixed4 _Color;
            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                float2 uv : TEXCOORD0;
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;
                return o;
            }
			fixed checker(float2 uv)
			{
				float2 repeatUV = uv*2;
				float2 c = floor(repeatUV)/2;
				float checker = frac(c.x + c.y)*2;
				return checker;
			}
            fixed4 frag (v2f i) : SV_Target
            {
                fixed col = checker(i.uv);
				return col;
            }
            ENDCG
        }
    }
}