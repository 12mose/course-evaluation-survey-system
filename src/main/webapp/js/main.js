// Course Evaluation System – main.js

document.addEventListener('DOMContentLoaded', function () {

    // ── Auto-dismiss flash alerts after 4 s ──────────────────────────────
    document.querySelectorAll('.alert').forEach(function (el) {
        setTimeout(function () {
            el.style.transition = 'opacity .5s, transform .5s';
            el.style.opacity   = '0';
            el.style.transform = 'translateY(-8px)';
            setTimeout(function () { el.remove(); }, 500);
        }, 4000);
    });

    // ── Confirm delete prompts (data-confirm attribute) ──────────────────
    document.querySelectorAll('[data-confirm]').forEach(function (el) {
        el.addEventListener('click', function (e) {
            if (!confirm(el.dataset.confirm)) e.preventDefault();
        });
    });

    // ── Ripple effect on all .btn elements ──────────────────────────────
    document.querySelectorAll('.btn').forEach(function (btn) {
        btn.addEventListener('click', function (e) {
            var ripple = document.createElement('span');
            var rect   = btn.getBoundingClientRect();
            var size   = Math.max(rect.width, rect.height);
            ripple.style.cssText =
                'position:absolute;border-radius:50%;pointer-events:none;' +
                'width:' + size + 'px;height:' + size + 'px;' +
                'left:' + (e.clientX - rect.left - size / 2) + 'px;' +
                'top:'  + (e.clientY - rect.top  - size / 2) + 'px;' +
                'background:rgba(255,255,255,.35);transform:scale(0);' +
                'animation:ripple .55s linear forwards;';
            btn.appendChild(ripple);
            setTimeout(function () { ripple.remove(); }, 600);
        });
    });

    // ── Entrance animations on table rows ───────────────────────────────
    document.querySelectorAll('.table tbody tr').forEach(function (tr, i) {
        tr.style.animation = 'slideUp .3s ease ' + (i * 0.04) + 's both';
    });

    // ── Active nav link highlight ────────────────────────────────────────
    var path = window.location.pathname;
    document.querySelectorAll('.nav-links a').forEach(function (a) {
        if (path.startsWith(a.getAttribute('href'))) {
            a.style.background = 'rgba(13,148,136,.14)';
            a.style.color = 'var(--primary)';
            a.style.fontWeight = '700';
        }
    });
});

/* ripple keyframe injected via JS */
(function () {
    var s = document.createElement('style');
    s.textContent = '@keyframes ripple{to{transform:scale(2.5);opacity:0}}';
    document.head.appendChild(s);
})();
