<#import "layout.ftlh" as layout>
<@layout.page title="Home">
    <h1>Character Gallery</h1>
    <p class="intro">A collection of iconic cartoon characters from across different animated universes.</p>

    <form class="search" method="get" action="/">
        <input type="text" name="name" placeholder="Search by name" value="${name!}">
        <select name="network" aria-label="Filter by network">
            <option value="">All networks</option>
            <#list networks as n>
                <option value="${n}"<#if n?lower_case == (network!'')?trim?lower_case> selected</#if>>${n}</option>
            </#list>
        </select>
        <button type="submit">Search</button>
        <#if name?has_content || network?has_content>
            <a class="clear" href="/">Clear</a>
        </#if>
    </form>

    <#if characters?has_content>
        <div class="gallery">
            <#list characters as c>
                <a href="/characters/${c.characterId?c}">
                    <div class="card">
                        <img src="${c.imageUrl?has_content?then(c.imageUrl, '/images/placeholder.svg')}" alt="${c.name}">
                        <h2>${c.name}</h2>
                        <ul>
                            <li>Network: ${c.network!'Unknown'}</li>
                            <li>Species: ${c.species!'Unknown'}</li>
                        </ul>
                    </div>
                </a>
            </#list>
        </div>
    <#else>
        <p class="empty">No characters found.</p>
    </#if>
</@layout.page>
