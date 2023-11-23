Shader "Hidden/NewImageEffectShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
	_Offset ("Ofsset", Float) = 0.1
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

            sampler2D _MainTex;
	    float _Offset;

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

	    fixed4 filter(float2 _uv)
	    {
		float3x3 weightmatrix = {1, 0, -1, 
					 2, 0, -2,
					 1, 0, -1};

		//float weightsum = 

		fixed4 col = weightmatrix[0][0] * tex2D(_MainTex, _uv - float2(_Offset, _Offset)) + weightmatrix[0][1] * tex2D(_MainTex, _uv + float2(0, _Offset)) + weightmatrix[0][2] * tex2D(_MainTex, _uv + float2(_Offset, _Offset))
			     + weightmatrix[1][0] * tex2D(_MainTex, _uv - float2(_Offset, 0)) + weightmatrix[1][1] * tex2D(_MainTex, _uv) + weightmatrix[1][2] * tex2D(_MainTex, _uv + float2(_Offset, 0))
			     + weightmatrix[2][0] * tex2D(_MainTex, _uv - float2(_Offset, _Offset)) + weightmatrix[2][1] * tex2D(_MainTex, _uv - float2(0, _Offset)) + weightmatrix[2][2] * tex2D(_MainTex, _uv + float2(_Offset, _Offset));

		return col;
	    }


            fixed4 frag (v2f i) : SV_Target
            {
		return (filter(i.uv));
            }
            ENDCG
        }
    }
}
