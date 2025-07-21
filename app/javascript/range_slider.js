import Chart from 'chart.js/auto';

let previewChart = null;

// レンジスライダーの値を更新する関数
window.updateRangeValue = function(slider, valueId) {
  const valueElement = document.getElementById(valueId);
  if (valueElement) {
    valueElement.textContent = slider.value;
  }
  
  // プレビューチャートを更新
  updatePreviewChart();
}

// プレビューチャートを更新する関数
function updatePreviewChart() {
  const previewCanvas = document.getElementById('preview-radar-chart');
  if (!previewCanvas) return;

  const sweetness = parseInt(document.querySelector('input[name="sake_log[sweetness]"]')?.value || 3);
  const sourness = parseInt(document.querySelector('input[name="sake_log[sourness]"]')?.value || 3);
  const spiciness = parseInt(document.querySelector('input[name="sake_log[spiciness]"]')?.value || 3);
  const bitterness = parseInt(document.querySelector('input[name="sake_log[bitterness]"]')?.value || 3);
  const umami = parseInt(document.querySelector('input[name="sake_log[umami]"]')?.value || 3);

  const data = [sweetness, sourness, spiciness, bitterness, umami];

  if (previewChart) {
    previewChart.data.datasets[0].data = data;
    previewChart.update('none'); // アニメーションなしで即座に更新
  } else {
    initializePreviewChart(previewCanvas, data);
  }
}

// プレビューチャートを初期化する関数
function initializePreviewChart(canvas, data) {
  const ctx = canvas.getContext('2d');
  
  previewChart = new Chart(ctx, {
    type: 'radar',
    data: {
      labels: ['甘味', '酸味', '辛味', '苦味', '旨味'],
      datasets: [{
        label: '味覚評価',
        data: data,
        backgroundColor: 'rgba(167, 243, 208, 0.4)',
        borderColor: 'rgba(34, 197, 94, 0.9)',
        borderWidth: 3,
        pointBackgroundColor: 'rgba(34, 197, 94, 1)',
        pointBorderColor: '#ffffff',
        pointBorderWidth: 2,
        pointRadius: 3, // 小さく変更（6 → 3）
        pointHoverRadius: 5, // ホバー時も小さく（8 → 5）
        tension: 0.1
      }]
    },
    options: {
      responsive: true,
      maintainAspectRatio: false,
      animation: {
        duration: 0 // プレビューではアニメーションを無効化
      },
      interaction: {
        intersect: false,
        mode: 'point'
      },
      plugins: {
        legend: {
          display: false
        },
        tooltip: {
          backgroundColor: 'rgba(0, 0, 0, 0.8)',
          titleColor: '#ffffff',
          bodyColor: '#ffffff',
          borderColor: 'rgba(34, 197, 94, 0.8)',
          borderWidth: 1,
          cornerRadius: 8,
          displayColors: false,
          callbacks: {
            title: function(context) {
              return context[0].label;
            },
            label: function(context) {
              const value = context.parsed.r;
              const levels = ['弱い', '少し弱い', '普通', '少し強い', '強い'];
              return `${value}/5 (${levels[value - 1] || '---'})`;
            }
          }
        }
      },
      scales: {
        r: {
          beginAtZero: true,
          min: 0,
          max: 5,
          ticks: {
            stepSize: 1,
            display: false, // 数字を非表示に
            color: '#94A3B8',
            font: {
              size: 11,
              weight: 500
            },
            backdropColor: 'transparent',
            showLabelBackdrop: false
          },
          grid: {
            color: 'rgba(148, 163, 184, 0.4)',
            lineWidth: 1
          },
          angleLines: {
            color: 'rgba(148, 163, 184, 0.4)',
            lineWidth: 1
          },
          pointLabels: {
            color: '#E2E8F0',
            font: {
              size: 13,
              weight: '600'
            },
            padding: 8
          }
        }
      }
    }
  });
}

// スライダーのスタイリング用のCSSを動的に追加
document.addEventListener('DOMContentLoaded', function() {
  const style = document.createElement('style');
  style.textContent = `
    .range-yellow::-webkit-slider-thumb {
      appearance: none;
      height: 20px;
      width: 20px;
      border-radius: 50%;
      background: #fbbf24;
      cursor: pointer;
      border: 2px solid #fff;
      box-shadow: 0 2px 4px rgba(0,0,0,0.2);
    }
    .range-green::-webkit-slider-thumb {
      appearance: none;
      height: 20px;
      width: 20px;
      border-radius: 50%;
      background: #10b981;
      cursor: pointer;
      border: 2px solid #fff;
      box-shadow: 0 2px 4px rgba(0,0,0,0.2);
    }
    .range-red::-webkit-slider-thumb {
      appearance: none;
      height: 20px;
      width: 20px;
      border-radius: 50%;
      background: #ef4444;
      cursor: pointer;
      border: 2px solid #fff;
      box-shadow: 0 2px 4px rgba(0,0,0,0.2);
    }
    .range-orange::-webkit-slider-thumb {
      appearance: none;
      height: 20px;
      width: 20px;
      border-radius: 50%;
      background: #f97316;
      cursor: pointer;
      border: 2px solid #fff;
      box-shadow: 0 2px 4px rgba(0,0,0,0.2);
    }
    .range-purple::-webkit-slider-thumb {
      appearance: none;
      height: 20px;
      width: 20px;
      border-radius: 50%;
      background: #8b5cf6;
      cursor: pointer;
      border: 2px solid #fff;
      box-shadow: 0 2px 4px rgba(0,0,0,0.2);
    }
  `;
  document.head.appendChild(style);
  
  // ページ読み込み時にプレビューチャートを初期化
  updatePreviewChart();
});

// Turboイベントにも対応
document.addEventListener('turbo:load', function() {
  updatePreviewChart();
});
