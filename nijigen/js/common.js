/*
 * Solo - A small and beautiful blogging system written in Java.
 * Copyright (c) 2010-2018, b3log.org & hacpai.com
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License
 * along with this program.  If not, see <https://www.gnu.org/licenses/>.
 */
/**
 * @fileoverview util and every page should be used.
 *
 * @author <a href="http://vanessa.b3log.org">Liyuan Li</a>
 * @version 0.2.1.0, Sep 30, 2018
 */

/**
 * @description 皮肤脚本
 * @static
 */



var Skin = {

  /**
   * @description 获取当前光标最后位置
   * @param {Dom} textarea 评论框对象
   * @returns {Num} 光标位置
   */
  _getCursorEndPosition: function (textarea) {
    textarea.focus();
    if (textarea.setSelectionRange) { // W3C
      return textarea.selectionEnd;
    } else if (document.selection) { // IE
      var i = 0,
          oS = document.selection.createRange(),
          oR = document.body.createTextRange();
      oR.moveToElementText(textarea);
      oS.getBookmark();
      for (i = 0; oR.compareEndPoints('StartToStart', oS) < 0 && oS.moveStart("character", -1) !== 0; i++) {
        if (textarea.value.charAt(i) === '\n') {
          i++;
        }
      }
      return i;
    }
  },
  _addCommentEmotion:function () {
    var _it = this;
    $("#custom_emotions>span").click(function () {
      var $comment = $("#comment");
      var endPosition = _it._getCursorEndPosition($comment[0]);
      var imageUrl = "!["+$(this).attr("title")+"]("+document.location.protocol +"//"+location.host + $(this).find("img").attr("src")+")",
          textValue = $comment[0].value;
      textValue = textValue.substring(0, endPosition) + imageUrl + textValue.substring(endPosition, textValue.length);
      $("#comment").val(textValue);
    });
  },
  _initCommon: function ($goTop) {
    $(window).scroll(function () {
      if ($(window).scrollTop() > 125) {
        $goTop.show()
      } else {
        $goTop.hide()
      }
    })
  },
  _initAnimation: function () {
    if (!('IntersectionObserver' in window)) {
      $('.item').addClass('item--active')
      return false
    }

    if (window.imageIntersectionObserver) {
      window.imageIntersectionObserver.disconnect()
      $('.item').each(function () {
        window.imageIntersectionObserver.observe(this)
      })
    } else {
      window.imageIntersectionObserver = new IntersectionObserver(
        function (entries) {
          entries.forEach(function (entrie) {
            if (typeof entrie.isIntersecting === 'undefined'
              ? entrie.intersectionRatio !== 0 : entrie.isIntersecting) {
              $(entrie.target).addClass('item--active')
            } else {
              if ($(entrie.target).closest('.side').length === 1 ||
                $(entrie.target).closest('.article-list').hasClass('content') ||
                $(entrie.target).outerHeight() > 768) {
                return
              }
              $(entrie.target).removeClass('item--active')
            }
          })
        })
      $('.item').each(function () {
        window.imageIntersectionObserver.observe(this)
      })
    }
  },
  init: function () {
    Util.initPjax(function () {
      Skin._initAnimation()
      if ($('#articlePage').length === 0) {
        $('.b3-solo-list').closest('.module').remove()
      }
    })

    Skin._initAnimation()

    $('body').on('click', '.content-reset img', function () {
      window.open(this.src)
    })

    this._initCommon($('.icon__up'))

    $('.header__nav a, .header__m a').each(function () {
      if (this.href === location.href) {
        this.className = 'current'
      }
    }).click(function () {
      $('.header__nav a, .header__m a').removeClass('current')
      this.className = 'current'
      $('.header__m .module__list').hide()
    })

    $('.header__logo').click(function () {
      $('.header__nav a, .header__m a').removeClass('current')
    })
  },
  _initArticleCommon: function () {
    if ($('.b3-solo-list li').length > 0 && $(window).width() > 1000) {
      $('.side').
        prepend('<div class="module"><div class="module__list"></div></div>')
      $('.side .module:eq(0) .module__list').html($('.b3-solo-list'))
    }
  },
   initArticle: function () {
    this._initArticleCommon()
    window.scroll(window.scrollX,0);
     this._addCommentEmotion();
    setTimeout(function () {
      if ($('#externalRelevantArticlesWrap li').length === 0) {
        $('#externalRelevantArticlesWrap').next().remove()
        $('#externalRelevantArticlesWrap').remove()
      }

      if ($('#relevantArticlesWrap li').length === 0) {
        $('#relevantArticlesWrap').prev().remove()
        $('#relevantArticlesWrap').remove()
      }

      if ($('#randomArticlesWrap li').length === 0) {
        $('#randomArticlesWrap').prev().remove()
        $('#randomArticlesWrap').remove()
      }
    }, 1000)
  },
}
Skin.init()