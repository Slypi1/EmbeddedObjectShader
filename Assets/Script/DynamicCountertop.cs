using UnityEngine;
using UnityEngine.UI;

public class DynamicCountertop : MonoBehaviour
{
    [SerializeField] private Material _material;
    [SerializeField] private Transform _shell;
    [SerializeField] private Vector2 _sinkSize;
    [SerializeField] private Button _calculationButton;

    private void Awake()
    {
        _calculationButton.onClick.AddListener(CalculateShaderApplication);
    }

    private void CalculateShaderApplication()
    {
        _material.SetVector("_Hole1Position", _shell.position);
        _material.SetVector("_Hole1Size", new Vector2(_sinkSize.x, _sinkSize.y));
    }
}
