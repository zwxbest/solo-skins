<div class="article-list">
    <#list articles as article>
    <article class="item <#if article_index &lt; 3>item--active</#if>">
        <time class="tooltipped tooltipped__n item__date"
              aria-label="${article.articleCreateDate?string("yyyy")}${yearLabel}">
            ${article.articleCreateDate?string("MM")}${monthLabel}
            <span class="item__day">${article.articleCreateDate?string("dd")}</span>
        </time>

        <h2 class="item__title">
            <a rel="bookmark" href="${servePath}${article.articlePermalink}">
                ${article.articleTitle}
            </a>
            <#if article.articlePutTop>
            <sup>
                ${topArticleLabel}
            </sup>
            </#if>
            <#if article.hasUpdated>
            <sup>
                ${updatedLabel}
            </sup>
            </#if>
        </h2>

        <div class="item__date--m fn__none">
            <i class="icon__date"></i>
            ${article.articleCreateDate?string("yyyy-MM-dd")}
        </div>


        <div class="ft__center">
            <span class="tag">
                <i class="icon__tags"></i>
                <#list article.articleTags?split(",") as articleTag>
                <a rel="tag" href="${servePath}/tags/${articleTag?url('UTF-8')}">
                ${articleTag}</a><#if articleTag_has_next>,</#if>
                </#list>
            </span>
            <a class="tag" href="${servePath}${article.articlePermalink}#comments">
                <i class="icon__comments"></i> ${article.articleCommentCount} ${commentLabel}
            </a>
            <span class="tag">
                <i class="icon__views"></i>
                ${article.articleViewCount} ${viewLabel}
            </span>
            <#if isLoggedIn>
             <span class="tag" onclick="window.location='/admin-index.do#article/article';
                                                 window.sessionStorage.article_id = '${article.oId}';window.sessionStorage.is_article='true';">
                 <i class="icon__pencil" ></i>
                 编辑
             </span>
            </#if>
        </div>

        <div class="content-reset">
            ${article.articleAbstractHtml}
        </div>
    </article>
    </#list>


    <#if 0 != paginationPageCount>
        <div class="fn__clear">
            <nav class="pagination fn__right">
                <#if 1 != paginationPageNums?first>
                    <a href="${servePath}${path}/${paginationPreviousPageNum}" class="pagination__item">&laquo;</a>
                    <a class="pagination__item" href="${servePath}${path}/1">1</a>
                    <span class="pagination__item pagination__item--text">...</span>
                </#if>
                <#list paginationPageNums as paginationPageNum>
                    <#if paginationPageNum == paginationCurrentPageNum>
                    <span class="pagination__item pagination__item--current">${paginationPageNum}</span>
                    <#else>
                    <a class="pagination__item" href="${servePath}${path}/${paginationPageNum}">${paginationPageNum}</a>
                    </#if>
                </#list>
                <#if paginationPageNums?last != paginationPageCount>
                    <span class="pagination__item pagination__item--text">...</span>
                    <a href="${servePath}${path}/${paginationPageCount}" class="pagination__item">${paginationPageCount}</a>
                    <a href="${servePath}${path}/${paginationNextPageNum}" class="pagination__item">&raquo;</a>
                </#if>
            </nav>
        </div>
    </#if>
</div>