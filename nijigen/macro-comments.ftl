<#--

    Solo - A small and beautiful blogging system written in Java.
    Copyright (c) 2010-2018, b3log.org & hacpai.com

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.

-->
<#macro comments commentList article>
<div class="comments__item">
    <div class="comments__meta comments__meta--only">${commentLabel}</div>
</div>

<ul class="comments" id="comments">
    <#list commentList as comment>
        <#include 'common-comment.ftl'/>
    </#list>
</ul>

<#if article.commentable>
<div class="comments__item">
    <div class="comments__meta">
        ${postCommentsLabel}
    </div>
    <div class="comments__content">
        <table id="commentForm" class="form">
            <tbody>
            <#if !isLoggedIn>
            <tr>
                <td>
                    <input placeholder="${commentNameLabel}" type="text" id="commentName"/>
                </td>
            </tr>
            <tr>
                <td>
                    <input placeholder="${commentEmailLabel}" type="email" id="commentEmail"/>
                </td>
            </tr>
            <tr>
                <td>
                    <input placeholder="${commentURLLabel}" type="url" id="commentURL"/>
                </td>
            </tr>
            </#if>
            <tr>
                <td id="custom_emotions" class="emotions">
                    <span class="em00" title="${em00Title}"><img src="/skins/nijigen/images/emotions/${em00Name}" alt="${em00Title}"/></span>
                    <span class="em01" title="${em01Title}"><img src="/skins/nijigen/images/emotions/${em01Name}" alt="${em01Title}"/></span>
                    <span class="em02" title="${em02Title}"><img src="/skins/nijigen/images/emotions/${em02Name}" alt="${em02Title}"/></span>
                    <span class="em03" title="${em03Title}"><img src="/skins/nijigen/images/emotions/${em03Name}" alt="${em03Title}"/></span>
                    <span class="em04" title="${em04Title}"><img src="/skins/nijigen/images/emotions/${em04Name}" alt="${em04Title}"/></span>
                    <span class="em05" title="${em05Title}"><img src="/skins/nijigen/images/emotions/${em05Name}" alt="${em05Title}"/></span>
                    <span class="em06" title="${em06Title}"><img src="/skins/nijigen/images/emotions/${em06Name}" alt="${em06Title}"/></span>
                    <span class="em07" title="${em07Title}"><img src="/skins/nijigen/images/emotions/${em07Name}" alt="${em07Title}"/></span>
                    <span class="em08" title="${em08Title}"><img src="/skins/nijigen/images/emotions/${em08Name}" alt="${em08Title}"/></span>
                    <span class="em09" title="${em09Title}"><img src="/skins/nijigen/images/emotions/${em09Name}" alt="${em09Title}"/></span>
                    <span class="em10" title="${em10Title}"><img src="/skins/nijigen/images/emotions/${em10Name}" alt="${em10Title}"/></span>
                    <span class="em11" title="${em11Title}"><img src="/skins/nijigen/images/emotions/${em11Name}" alt="${em11Title}"/></span>
                    <span class="em12" title="${em12Title}"><img src="/skins/nijigen/images/emotions/${em12Name}" alt="${em12Title}"/></span>
                    <span class="em13" title="${em13Title}"><img src="/skins/nijigen/images/emotions/${em13Name}" alt="${em13Title}"/></span>
                    <span class="em14" title="${em14Title}"><img src="/skins/nijigen/images/emotions/${em14Name}" alt="${em14Title}"/></span>
                    <span class="em15" title="${em15Title}"><img src="/skins/nijigen/images/emotions/${em15Name}" alt="${em15Title}"/></span>


                </td>
            </tr>
            <tr>
                <td>
                    <textarea rows="5" cols="96" id="comment"></textarea>
                </td>
            </tr>
            <#if !isLoggedIn>
            <tr>
                <td>
                    <input style="width:50%" placeholder="${captchaLabel}" type="text"
                           id="commentValidate"/>
                    <img class="comments__captcha" id="captcha" alt="validate" src="${servePath}/captcha.do"/>
                </td>
            </tr>
            </#if>
            <tr>
                <td colspan="2" align="right">
                    <span class="ft__red" id="commentErrorTip"></span>
                    <button class="btn tag" id="submitCommentButton" onclick="page.submitComment();">${submmitCommentLabel}</button>
                </td>
            </tr>
            </tbody>
        </table>
    </div>
</div>
</#if>
</#macro>

<#macro comment_script oId>
<script type="text/javascript" src="${staticServePath}/js/page${miniPostfix}.js?${staticResourceVersion}"
        charset="utf-8"></script>
<script type="text/javascript">
    var page = new Page({
        'nameTooLongLabel': "${nameTooLongLabel}",
        'mailCannotEmptyLabel': "${mailCannotEmptyLabel}",
        'mailInvalidLabel': "${mailInvalidLabel}",
        'commentContentCannotEmptyLabel': "${commentContentCannotEmptyLabel}",
        'captchaCannotEmptyLabel': "${captchaCannotEmptyLabel}",
        'loadingLabel': "${loadingLabel}",
        'oId': "${oId}",
        'skinDirName': "${skinDirName}",
        'blogHost': "${blogHost}",
        'randomArticles1Label': "${randomArticles1Label}",
        'externalRelevantArticles1Label': "${externalRelevantArticles1Label}",
    })
    var replyTo = function (id) {
        var commentFormHTML = '<table class=\'form comments__reply comments__content\' id=\'replyForm\'>'
        page.addReplyForm(id, commentFormHTML)
    };
    (function () {
        page.load()
        Skin.initArticle()
        // emotions
        page.replaceCommentsEm('#comments .content-reset')
        <#nested>
    })()
</script>
</#macro>