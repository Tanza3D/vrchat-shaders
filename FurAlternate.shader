Shader "Tanza/Fur" {
 
Properties {
      _Color ("Color", Color) = (1,1,1,1)
      _MainTex ("Albedo (RGB) - UV 2", 2D) = "white" {}
      _AlphaTex ("Alpha (A) - UV 1", 2D) = "white" {}
      _Glossiness ("Smoothness", Range(0,1)) = 0.5
      _Cutout ("Cutout", Range(0,1)) = 0.0
}
 
SubShader {
    Tags {"Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent"}
    LOD 200    
    ZWrite Off
    Blend SrcAlpha OneMinusSrcAlpha

    CGPROGRAM
    #pragma surface surf Standard fullforwardshadows addshadow alpha alphatest:_Cutout
    #pragma target 3.0
 
    sampler2D _MainTex;
    sampler2D _AlphaTex;
    
    struct Input{
        float2 uv_MainTex : TEXCOORD0;
        float2 uv2_AlphaTex : TEXCOORD1;
    };
   
    fixed4 _Color;
    half _Glossiness;
 
    UNITY_INSTANCING_BUFFER_START(Props)
    // put more per-instance properties here
    UNITY_INSTANCING_BUFFER_END(Props)
      
    void surf (Input IN, inout SurfaceOutputStandard o)
    {
        fixed4 c = tex2D (_MainTex, IN.uv2_AlphaTex) * _Color;
        o.Albedo = c.rgb;
        fixed4 c_a = tex2D (_AlphaTex, IN.uv_MainTex) * _Color;
        o.Alpha = c_a.a;
        o.Smoothness = _Glossiness;
    }
 
    ENDCG
}
 
FallBack "Diffuse"
 
}
