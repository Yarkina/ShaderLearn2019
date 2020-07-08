Shader "Custom/CurveTest"
{
	Properties
	{
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_What("what",float) = 200
	}
	SubShader
	{
		// No culling or depth

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			sampler2D _MainTex;
			float _What;
			struct appdata
			{
				float4 vertex : POSITION;
				float2 texcoord : TEXCOORD0;

			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 pos : SV_POSITION;
			};

			v2f vert (appdata v)
			{
				v2f o;
				float3 vPos = UnityObjectToViewPos(v.vertex);
				// float zOff = vPos.z/_What;
				// vPos += float3(15,0,0)*zOff*zOff;
				o.pos = mul(UNITY_MATRIX_P,vPos);
				o.uv = v.texcoord;
				return o;
			}
			fixed4 frag (v2f i) : SV_Target
			{
				return tex2D(_MainTex,i.uv);   
			}
			ENDCG
		}
	}
}