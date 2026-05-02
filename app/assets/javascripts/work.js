(function ($) {
  $(function () {
    const $root = $("[data-work-area]");
    if ($root.length === 0) return;

    const $image = $root.find("[data-work-image]");
    const $title = $root.find("[data-work-image-title]");
    const $average = $root.find("[data-work-average]");
    const $indexLabel = $root.find("[data-work-index]");
    const $imageId = $root.find("[data-work-image-id]");
    const $buttons = $root.find("[data-work-nav]");

    const dataValue = function (name) {
      return $root.attr(`data-${name}`);
    };

    const setBusy = function (busy) {
      $buttons.prop("disabled", busy || Number(dataValue("images-count")) < 2);
    };

    const updateImage = function (data) {
      $root.attr("data-current-index", data.index);
      $root.attr("data-theme-id", data.theme_id);
      $root.attr("data-images-count", data.images_arr_size);

      $title.text(data.name);
      $average.text(data.common_ave_value);
      $indexLabel.text(`${data.index + 1} / ${data.images_arr_size}`);
      $image.attr({ src: data.image_url, alt: data.name });
      $imageId.val(data.image_id);
    };

    const navigate = function (direction) {
      const url = direction === "next" ? dataValue("next-image-url") : dataValue("prev-image-url");

      setBusy(true);

      $.ajax({
        url: url,
        method: "GET",
        dataType: "json",
        data: {
          theme_id: dataValue("theme-id"),
          index: dataValue("current-index")
        }
      }).done(updateImage)
        .fail(function (_xhr, _status, error) {
          console.error(`Image navigation failed: ${error}`);
        })
        .always(function () {
          setBusy(false);
        });
    };

    $buttons.on("click", function () {
      navigate($(this).attr("data-work-nav"));
    });
  });
})(window.jQuery);
