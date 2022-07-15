package com.samplereactnative;

import com.acesso.acessobio_android.onboarding.IAcessoBioTheme;

public class UnicoTheme implements IAcessoBioTheme {

    @Override
    public Object getColorBackground() {
        return R.color.colorGray;
    }

    @Override
    public Object getColorBoxMessage() {
        return R.color.colorWhite;
    }

    @Override
    public Object getColorTextMessage() {
        return R.color.colorBlack;
    }

    @Override
    public Object getColorBackgroundPopupError() {
        return R.color.colorBlueMask;
    }

    @Override
    public Object getColorTextPopupError() {
        return R.color.colorBlack;
    }

    @Override
    public Object getColorBackgroundButtonPopupError() {
        return R.color.colorBlueMask;
    }

    @Override
    public Object getColorTextButtonPopupError() {
        return R.color.colorBlack;
    }

    @Override
    public Object getColorBackgroundTakePictureButton() {
        return R.color.colorBlueMask;
    }

    @Override
    public Object getColorIconTakePictureButton() {
        return R.color.colorBlack;
    }

    @Override
    public Object getColorBackgroundBottomDocument() {
        return R.color.colorBlueMask;
    }

    @Override
    public Object getColorTextBottomDocument() {
        return R.color.colorBlack;
    }

    @Override
    public Object getColorSilhouetteSuccess() {
        return R.color.colorGreen;
    }

    @Override
    public Object getColorSilhouetteError() {
        return R.color.colorOrange;
    }

    @Override
    public Object getColorSilhouetteNeutral() {
        return R.color.colorWhite;
    }
}
