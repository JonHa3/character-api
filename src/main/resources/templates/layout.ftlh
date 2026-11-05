<#-- Shared page layout. Every page wraps its content in <@layout.page title="...">...</@layout.page>. -->
<#macro page title>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>${title} | Character Gallery</title>
    <link rel="stylesheet" href="/css/styles.css">
</head>
<body>
    <nav>
        <a href="/">Home</a>
        <a href="/about">About</a>
        <a href="/characters/new">Add a Character</a>
    </nav>

    <#-- One-time success message, set with RedirectAttributes.addFlashAttribute("message", ...) -->
    <#if message??>
        <p class="flash">${message}</p>
    </#if>

    <main>
        <#nested>
    </main>

    <footer>
        <p>&copy; 2026 Character Gallery. Created for a CSC-340 assignment.</p>
    </footer>
</body>
</html>
</#macro>
