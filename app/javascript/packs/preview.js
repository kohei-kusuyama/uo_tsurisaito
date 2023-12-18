if (document.URL.includes('new')) {
  document.addEventListener('DOMContentLoaded', () => {
    const imagePreviewContainer = document.getElementById('new-image');
    const fileInput = document.getElementById('post_post_image');

    fileInput.addEventListener('change', (e) => {
      const file = e.target.files[0];

      if (file) {
        // 画像ファイルが選択された場合、プレビューを表示
        const reader = new FileReader();

        reader.onload = (readerEvent) => {
          const previewImage = document.createElement('img');
          previewImage.src = readerEvent.target.result;
          previewImage.style.maxWidth = '100%'; // プレビュー画像の幅を調整するために設定

          // プレビューを表示する前に既存のプレビューをクリア
          imagePreviewContainer.innerHTML = '';

          // プレビューを追加
          imagePreviewContainer.appendChild(previewImage);
        };

        // 画像ファイルを読み込んでプレビューを生成
        reader.readAsDataURL(file);
      } else {
        // ファイルが選択されていない場合、プレビューをクリア
        imagePreviewContainer.innerHTML = '';
      }
    });
  });
}
