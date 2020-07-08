using System.Collections;
using System.Collections.Generic;
using UnityEngine;
 
public class WaveCreame : MonoBehaviour {
 
 
    public Shader waveShader = null;
    [Range(0.0f,1f)]
    public float waveWidth = 0.3f;
    private Material m_WaveMaterial = null;
    private float m_CenterX = 0.5f;
    private float m_CenterY = 0.5f;
	// Use this for initialization
	void Start () {
        m_WaveMaterial = new Material(waveShader);
	}
	
	// Update is called once per frame
	void Update () {
        Vector3 pos = Input.mousePosition;
        m_CenterX = pos.x / Screen.width;
        m_CenterY = pos.y / Screen.height;
        if (Input.GetMouseButton(0)) {
            waveWidth += Time.deltaTime * 0.5f;
        }
        if (Input.GetMouseButton(1))
        {
            waveWidth -= Time.deltaTime * 0.5f;
        }
    }
 
    private void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        if (waveShader == null || m_WaveMaterial == null) return;
        m_WaveMaterial.SetFloat("_WaveWidth", waveWidth);
        m_WaveMaterial.SetFloat("_CenterX", m_CenterX);
        m_WaveMaterial.SetFloat("_CenterY", m_CenterY);
        Graphics.Blit(source, destination, m_WaveMaterial);
    }
}

