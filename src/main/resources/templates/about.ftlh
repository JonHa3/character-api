<#import "layout.ftlh" as layout>
<@layout.page title="About">
    <div class="page-content">
        <h1>About This Site</h1>
        <img src="/images/gumball-details.png" alt="Gumball Waterson">

        <p>Character Gallery is a showcase site built for CSC-340, bringing together some of my favorite cartoon and animated characters in one place. I chose Gumball Waterson as the site's featured character because The Amazing World of Gumball was my favorite childhood cartoon, and his chaotic, colorful energy felt like the perfect fit for a project about celebrating cartoon characters.</p>

        <p>For the design, I used an "Elmore style" template as inspiration, since it echoes the same bright, playful vibe as Gumball's world. A dark navigation bar with a purple accent color ties every page together, character cards use a clean grid layout so visitors can browse at a glance, and each details page goes deeper into one character's backstory, network, and first appearance.</p>

        <p>The site started as a static page with a search bar and form that did nothing. Now everything is connected to a real database: you can search by name or network, add new characters, edit them, and remove them.</p>

        <h2>How It's Built</h2>
        <p>The app is a Spring Boot application with a PostgreSQL database hosted on Neon, deployed on Render. It is organized in layers, and each layer only talks to the one below it:</p>
        <ul>
            <li><strong>Templates (FreeMarker):</strong> the HTML pages you see. A shared layout supplies the navigation bar, footer, and success messages for every page.</li>
            <li><strong>Page controller:</strong> receives each browser request, asks the service for data, places it in the model, and picks which template to render. After a form is saved it redirects, so refreshing the page never submits it twice.</li>
            <li><strong>Service:</strong> holds the business logic, such as combining the name and network filters and copying edited fields onto an existing character.</li>
            <li><strong>Repository (Spring Data JPA):</strong> turns method calls into SQL queries against the database.</li>
        </ul>
        <p>The same service layer also powers a JSON REST API at <a href="/api/characters">/api/characters</a>. The pages are built on the server and call the service directly, while the API serves the same data to any other client. One back end, two front ends.</p>
    </div>
</@layout.page>
