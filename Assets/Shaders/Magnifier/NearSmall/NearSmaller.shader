Shader "Custom/Magnifier/NearSmaller"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_Scale("Scale",float) = 0.5
		_CenterX("CenterX",float)=0.5
		_CenterY("CenterY",float)=0.5
	}
	SubShader
	{
		// No culling or depth
		Cull Off ZWrite Off ZTest Always

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;

			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
				float distance:TEXCOORD1;
			};


			float _Scale;
			float _CenterX;
			float _CenterY;
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;
				//相机坐标系的物体坐标
				float3 posView = UnityObjectToViewPos (v.vertex);
				//计算与相机距离
				o.distance = length(posView);
				return o;
			}
			
			sampler2D _MainTex;

			fixed4 frag (v2f i) : SV_Target
			{
				float2 center=float2(_CenterX,_CenterY);
				float2 distance= center - i.uv;
				float x=center.x+ center.x*(-distance.x/center.x) *(i.distance-_Scale);
				float y=center.y+ center.y*(-distance.y/center.y) *(i.distance-_Scale);
				float2 uv = float2(x,y);
				return tex2D(_MainTex, uv);   
			}
			ENDCG
		}
	}
}