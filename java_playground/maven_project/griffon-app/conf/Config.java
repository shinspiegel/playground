import griffon.util.AbstractMapResourceBundle;

import javax.annotation.Nonnull;
import java.util.Map;

import static java.util.Arrays.asList;
import static griffon.util.CollectionUtils.map;

public class Config extends AbstractMapResourceBundle {
    @Override
    protected void initialize(@Nonnull Map<String, Object> entries) {
        map(entries)
            .e("application", map()
                .e("title", "app")
                .e("startupGroups", asList("app"))
                .e("autoShutdown", true)
            )
            .e("mvcGroups", map()
                .e("app", map()
                    .e("model", "com.example.AppModel")
                    .e("view", "com.example.AppView")
                    .e("controller", "com.example.AppController")
                )
            );
    }
}